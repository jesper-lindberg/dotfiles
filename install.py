#!/usr/bin/env python3

import subprocess
import platform
import shutil
from pathlib import Path
from typing import dict, Optional


class Style:
    BLUE: str = "\033[0;34m"
    GREEN: str = "\033[0;32m"
    YELLOW: str = "\033[1;33m"
    RED: str = "\033[0;31m"
    RESET: str = "\033[0m"
    BOLD: str = "\033[1m"


DOTFILES_DIR: Path = Path.home() / ".dotfiles"

# Configuration
SYMLINKS: dict[str, str] = {
    "config/fish": ".config/fish",
    "config/nvim": ".config/nvim",
    "config/hammerspoon": ".hammerspoon",
    "config/starship.toml": ".config/starship.toml",
    "config/git/.gitconfig": ".gitconfig",
    "config/tmux/.tmux.conf": ".tmux.conf",
}


def run(
    cmd: str, check: bool = True, capture: bool = False
) -> subprocess.CompletedProcess:
    """Execute shell command"""
    if capture:
        return subprocess.run(
            cmd, shell=True, check=check, capture_output=True, text=True
        )
    return subprocess.run(cmd, shell=True, check=check)


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
    src: Path = DOTFILES_DIR / source
    dest: Path = Path.home() / target

    if not src.exists():
        warning(f"Source not found: {source}")
        return False

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


def install_homebrew() -> bool:
    """Install Homebrew on macOS"""
    if command_exists("brew"):
        success("Homebrew already installed")
        return True

    info("Installing Homebrew...")
    result: subprocess.CompletedProcess = run(
        '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"',
        check=False,
    )

    if result.returncode == 0:
        success("Homebrew installed")
        return True
    else:
        error("Failed to install Homebrew")
        return False


def setup_fish_shell() -> bool:
    """Set Fish as default shell"""
    if not command_exists("fish"):
        warning("Fish shell not installed, skipping...")
        return False

    info("Setting Fish as default shell...")
    fish_path: str = run("which fish", capture=True).stdout.strip()

    # Add fish to /etc/shells if not present
    result: subprocess.CompletedProcess = run(
        f"grep -q {fish_path} /etc/shells", check=False
    )
    if result.returncode != 0:
        run(f"echo {fish_path} | sudo tee -a /etc/shells")

    # Change default shell
    run(f"chsh -s {fish_path}", check=False)
    success("Fish shell configured")
    return True


def install_dotfiles() -> None:
    """Main installation function"""
    print(f"{Style.BOLD}{Style.BLUE}")
    print("╔════════════════════════════════════╗")
    print("║   Dotfiles Installation Script     ║")
    print("╚════════════════════════════════════╝")
    print(Style.RESET)

    os_type: str = platform.system()

    # Ensure dotfiles directory exists
    if not DOTFILES_DIR.exists():
        error(f"Dotfiles directory not found at {DOTFILES_DIR}")
        print("\nClone your dotfiles first:")
        print(f"  git clone <your-repo-url> {DOTFILES_DIR}")
        return

    # Platform-specific setup
    if os_type == "Darwin":
        header("macOS Setup")

        info("Installing Xcode Command Line Tools...")
        run("xcode-select --install", check=False)

        install_homebrew()

    elif os_type == "Linux":
        header("Linux Setup")
        info("Linux detected - manual package installation required")

    # Shell configuration
    header("Configuring Shell & Tools")
    setup_fish_shell()

    # Create all symlinks
    header("Creating Symlinks")
    success_count: int = 0
    for source, target in SYMLINKS.items():
        if create_symlink(source, target):
            success_count += 1

    print(
        f"\n  {Style.GREEN}✓ {success_count}/{len(SYMLINKS)} symlinks created{Style.RESET}"
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
