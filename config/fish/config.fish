# Set environment variables
set -gx PATH /usr/local/bin /usr/local/sbin ~/go/bin $HOME/.node/bin node_modules/.bin vendor/bin $PATH
set -gx GOPATH ~/go
set -gx GOPRIVATE github.com/sybogames

# Set up theme
set -g theme_display_git yes
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked no
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_master_branch yes
set -g theme_display_k8s_context yes
set -g theme_display_vi yes
set -g theme_title_display_process yes
set -g theme_title_display_path yes
set -g theme_title_display_user no
set -g theme_title_use_abbreviated_path yes
set -g theme_avoid_ambiguous_glyphs yes
set -g theme_powerline_fonts yes
set -g theme_nerd_fonts no
set -g theme_show_exit_status yes
set -g theme_project_dir_length 1
set -g theme_newline_cursor yes
set -g theme_color_scheme ayu
set -g fish_prompt_pwd_dir_length 20

# Set up aliases
alias reset-samba-passwd="docker run --rm -it dperson/samba bash -c ""smbpasswd -U jesperl -r sybogames.local"""
alias docker-stop-all="docker stop (docker ps -a -q)"
alias vim nvim
alias ls exa
alias root="cd (git rev-parse --show-cdup)"
