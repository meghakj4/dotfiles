function fish_greeting
	echo -e (uname -ro | awk '{print " \\\\e[1mOS: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e (uptime | sed 's/^.*up  *\([^,]*\),.*/\1/' | awk '{print " \\\\e[1mUptime: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e (uname -n | awk '{print " \\\\e[1mHostname: \\\\e[0;32m"$0"\\\\e[0m"}')

	echo -e " \e[1mTodos:\e[0;32m"
	if test -s ~/todo
		set_color magenta
		cat ~/todo | sed 's/^/ /'
		echo
	end
	set_color normal
end

starship init fish | source
zoxide init --cmd cd fish | source
if status is-interactive
    atuin init fish | source
end

fzf --fish | source

set EDITOR nvim
set -Ux MANPAGER "nvim +Man! -c 'set ft=man'"
set -Ux GEMINI_API_KEY "AIzaSyDAMXwNEXucTh3glxRRn3yC8fMdSVa-B9w"
set -Ux LAZYGIT_CONFIG_PATH "$HOME/.config/lazygit/config.yml:$HOME/.local/share/tinted-theming/tinty/artifacts/tinted-lazygit-themes-file.yml"
fish_add_path ~/.local/bin ~/scripts

# Fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3

# Replace ls with eza
alias ls='eza --icons --git'

# Long format, shows all files, with headers
alias ll='eza --long --all --header --icons --git'

alias y='yazi'

alias v='nvim'
alias ta='tmux attach'
alias lg='lazygit'
alias pms='podman machine stop'
alias pmS='podman machine start'
alias gta='cd ~/Documents/Desk/Apps'
alias hideicons='defaults write com.apple.finder CreateDesktop false'
alias showicons='defaults write com.apple.finder CreateDesktop true'
alias tf="terraform"
alias ff="fastfetch"
alias tns="tmux new-session -s (pwd | path basename)"
alias tks="tmux kill-server"
alias tls="tmux list-sessions"
alias bat="bat --theme='base16-256'"
alias lc="leetrs"
alias cg="cargo"

# git aliases
alias gs="git status"
alias gd="git diff"
alias gds="git diff --staged"
alias gla="git log --oneline --graph --decorate --all"
alias gl="git log --oneline --graph --decorate"
alias gll="git log --stat"
alias gsw="git switch"

alias ga="git add"
alias gaa="git add --all"
alias gr="git restore"
alias grs="git restore --staged"

alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit --amend"
alias gcan="git commit --amend --no-edit"

alias gb="git branch"
alias gba="git branch --all"
alias gbd="git branch -d"
alias gbD="git branch -D"

alias gf="git fetch"
alias gfa="git fetch --all --prune"
alias gp="git pull"
alias gP="git push"

alias gst="git stash"
alias gstp="git stash pop"
alias gstl="git stash list"
alias gundo="git reset --soft HEAD~1"

function gop
    set full_remote (git remote get-url origin)

    if string match -q "https*" $full_remote
        set user (echo $full_remote | awk -F'/' '{print $4}')
        set repo (echo $full_remote | awk -F'/' '{print $5}' | sed 's/\.git$//')
    else
        set user (echo $full_remote | awk -F'[:/]' '{print $2}')
        set repo (echo $full_remote | awk -F'[:/]' '{print $3}' | sed 's/\.git$//')
    end

    open "https://github.com/$user/$repo"
end

function gco --wraps "git switch"
    git switch $argv
end

function gnew --wraps "git switch -c"
    git switch -c $argv
end


# # Yazi cd integration
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end


# A function to list all tinty themes and select one (or cycle)
function theme
    if test "$argv[1]" = "cycle"
        tinty cycle
    else
        set themes (tinty list)
        set selected (printf '%s\n' $themes | fzf --prompt="Select a tinty theme: ")
        if test -n "$selected"
            tinty apply "$selected"
        end
    end

    tmux source-file ~/.tmux.conf 2>/dev/null
end

# Sourcing active tinty theme for shell, terminal ANSI colors & fzf
if test -f ~/.local/share/tinted-theming/tinty/artifacts/tinted-shell-scripts-file.sh
    sh ~/.local/share/tinted-theming/tinty/artifacts/tinted-shell-scripts-file.sh
end
if test -f ~/.local/share/tinted-theming/tinty/artifacts/tinted-fzf-fish-file.fish
    source ~/.local/share/tinted-theming/tinty/artifacts/tinted-fzf-fish-file.fish
end


function wallpaper --wraps "wallpaper-select"
    wallpaper-select $argv
end

function apps
    set dirs (fd -t d -d 1 . ~/Documents/Desk/Apps | awk -F/ '{print $7}' | fzf)
    if test -n "$dirs"
        cd ~/Documents/Desk/Apps/$dirs
    end
end

function sudolast
    sudo (history --max=1)
end

bind \cr _atuin_bind_up
bind -M insert \cr _atuin_bind_up

bind ctrl-shift-t 'theme cycle'

bind up up-or-search
bind -M insert up up-or-search

