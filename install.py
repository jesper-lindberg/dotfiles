#!/usr/bin/env python3

import os
import platform
import shutil
import subprocess
from pathlib import Path
from typing import Optional


class Style:
    BLUE: str = "\033[0;34m"
    GREEN: str = "\033[0;32m"
    YELLOW: str = "\033[1;33m"
    RED: str = "\033[0;31m"
    RESET: str = "\033[0m"
    BOLD: str = "\033[1m"


DOTFILES_DIR = Path(__file__).parent.resolve()

# Configuration
SYMLINKS_COMMON: dict[str, str] = {
    "config/fish": ".config/fish",
    "config/nvim": ".config/nvim",
    "config/zed": ".config/zed",
    "config/starship.toml": ".config/starship.toml",
    "config/git/.gitconfig": ".gitconfig",
    "config/tmux/.tmux.conf": ".tmux.conf",
}

SYMLINKS_MACOS: dict[str, str] = {
    "config/hammerspoon": ".hammerspoon",
}

SYMLINKS_LINUX: dict[str, str] = {
    # Add Linux-specific symlinks here if needed
}


def get_symlinks() -> dict[str, str]:
    """Get symlinks based on current OS"""
    symlinks = SYMLINKS_COMMON.copy()
    os_type = platform.system()

    if os_type == "Darwin":
        symlinks.update(SYMLINKS_MACOS)
    elif os_type == "Linux":
        symlinks.update(SYMLINKS_LINUX)

    return symlinks


def run_shell(cmd: str, check: bool = True) -> int:
    """Execute shell command, return exit code"""
    result = subprocess.run(cmd, shell=True, text=True)
    if check and result.returncode != 0:
        raise subprocess.CalledProcessError(result.returncode, cmd)
    return result.returncode


def run_capture(cmd: list[str]) -> str:
    """Execute command safely and capture output"""
    result = subprocess.run(cmd, capture_output=True, text=True, check=True)
    return result.stdout.strip()


def command_exists(cmd: str) -> bool:
    """Check if command is available"""
    return shutil.which(cmd) is not None


def header(text: str) -> None:
    print(f"\n{Style.BOLD}{Style.BLUE}▸ {text}{Style.RESET}\n")


def info(text: str) -> None:
    print(f"  {Style.YELLOW}→{Style.RESET} {text}")


def success(text: str) -> None:
    print(f"  {Style.GREEN}✓{Style.RESET} {Style.GREEN}{text}{Style.RESET}")


def error(text: str) -> None:
    print(f"  {Style.RED}✗{Style.RESET} {Style.RED}{text}{Style.RESET}")


def warning(text: str) -> None:
    print(f"  {Style.YELLOW}⚠{Style.RESET} {Style.YELLOW}{text}{Style.RESET}")


def create_symlink(source: str, target: str) -> bool:
    """Create symlink from dotfiles to home directory"""
    src = DOTFILES_DIR / source
    dest = Path.home() / target

    if not src.exists():
        warning(f"Source not found: {source}")
        return False

    # Check if already linked correctly
    if dest.is_symlink() and dest.resolve() == src:
        return True

    # Create parent directory if needed
    dest.parent.mkdir(parents=True, exist_ok=True)

    # Remove existing symlink or file
    if dest.exists() or dest.is_symlink():
        if dest.is_dir() and not dest.is_symlink():
            shutil.rmtree(dest)
        else:
            dest.unlink()

    # Create symlink
    dest.symlink_to(src)
    success(f"Linked {target}")
    return True


def get_brew_path() -> Optional[str]:
    """Get Homebrew path, checking platform-specific locations"""
    # Apple Silicon Macs use /opt/homebrew
    if Path("/opt/homebrew/bin/brew").exists():
        return "/opt/homebrew/bin/brew"
    # Intel Macs use /usr/local
    if Path("/usr/local/bin/brew").exists():
        return "/usr/local/bin/brew"
    # Linux uses /home/linuxbrew
    if Path("/home/linuxbrew/.linuxbrew/bin/brew").exists():
        return "/home/linuxbrew/.linuxbrew/bin/brew"
    # Check if brew is in PATH
    return shutil.which("brew")


def install_homebrew() -> bool:
    """Install Homebrew"""
    if get_brew_path():
        success("Homebrew already installed")
        return True

    info("Installing Homebrew...")
    exit_code = run_shell(
        '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"',
        check=False,
    )

    if exit_code == 0:
        success("Homebrew installed")
        # Add to PATH for this session
        brew_path = get_brew_path()
        if brew_path:
            os.environ["PATH"] = f"{Path(brew_path).parent}:{os.environ['PATH']}"
        return True

    error("Failed to install Homebrew")
    return False


def install_brew_packages() -> None:
    """Install packages from Brewfile"""
    brewfile = DOTFILES_DIR / "Brewfile"

    if not brewfile.exists():
        warning("Brewfile not found, skipping package installation")
        return

    brew_path = get_brew_path()
    if not brew_path:
        error("Homebrew not found, cannot install packages")
        return

    info("Updating Homebrew...")
    _ = run_shell(f"{brew_path} update")
    success("Homebrew updated")

    info("Installing packages from Brewfile...")
    _ = run_shell(f"{brew_path} bundle --file={brewfile}")
    success("Packages installed")


def setup_fish_shell() -> bool:
    """Set Fish as default shell"""
    if not command_exists("fish"):
        warning("Fish shell not installed, skipping...")
        return False

    info("Setting Fish as default shell...")
    fish_path = run_capture(["which", "fish"])

    # Add fish to /etc/shells if not present
    if run_shell(f"grep -q {fish_path} /etc/shells", check=False) != 0:
        _ = run_shell(f"echo {fish_path} | sudo tee -a /etc/shells")

    # Change default shell (may require password)
    os_type = platform.system()
    if os_type == "Linux":
        info("You may be prompted for your password to change the default shell")
    _ = run_shell(f"chsh -s {fish_path}", check=False)
    success("Fish shell configured")
    return True


def install_dotfiles() -> None:
    """Main installation function"""
    print(f"{Style.BOLD}{Style.BLUE}")
    print("╔════════════════════════════════════╗")
    print("║   Dotfiles Installation Script     ║")
    print("╚════════════════════════════════════╝")
    print(Style.RESET)

    os_type = platform.system()

    # Platform-specific setup
    if os_type == "Darwin":
        header("macOS Setup")

        info("Installing Xcode Command Line Tools...")
        _ = run_shell("xcode-select --install", check=False)

        _ = install_homebrew()
        install_brew_packages()

    elif os_type == "Linux":
        header("Linux Setup")

        _ = install_homebrew()
        install_brew_packages()

    # Shell configuration
    header("Configuring Shell & Tools")
    _ = setup_fish_shell()

    # Create all symlinks
    header("Creating Symlinks")
    success_count = 0
    symlinks = get_symlinks()

    for source, target in symlinks.items():
        if create_symlink(source, target):
            success_count += 1

    print(
        f"\n  {Style.GREEN}✓ {success_count}/{len(symlinks)} symlinks created{Style.RESET}"
    )

    print(f"\n{Style.BOLD}{Style.GREEN}✓ Installation complete!{Style.RESET}\n")


def main() -> None:
    try:
        install_dotfiles()
    except KeyboardInterrupt:
        print(f"\n{Style.YELLOW}Installation cancelled{Style.RESET}")
        exit(1)
    except Exception as e:
        error(f"Error: {e}")
        exit(1)


if __name__ == "__main__":
    main()
