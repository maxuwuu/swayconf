# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
eval "$(starship init bash)"
neofetch

detect_package_manager() {
    if command -v apt &> /dev/null; then
        echo "apt"
    elif command -v pacman &> /dev/null; then
        echo "pacman"
    elif command -v dnf &> /dev/null; then
        echo "dnf"
    elif command -v zypper &> /dev/null; then
        echo "zypper"
    elif command -v emerge &> /dev/null; then
        echo "emerge"
    else
        echo "unknown"
    fi
}

PKG_MGR=$(detect_package_manager)

alias nano='STARSHIP_DIR_STYLE="bold green" nano'
alias sudo='STARSHIP_DIR_STYLE="bold yellow" sudo'

case "$PKG_MGR" in
  apt)
    alias update='STARSHIP_DIR_STYLE="bold blue" sudo apt update && sudo apt upgrade -y'
    alias install='STARSHIP_DIR_STYLE="bold #FFA500" sudo apt install'
    alias remove='STARSHIP_DIR_STYLE="bold red" sudo apt remove'
    ;;
  pacman)
    alias update='STARSHIP_DIR_STYLE="bold blue" sudo pacman -Syu'
    alias install='STARSHIP_DIR_STYLE="bold #FFA500" sudo pacman -S'
    alias remove='STARSHIP_DIR_STYLE="bold red" sudo pacman -R'
    ;;
  dnf)
    alias update='STARSHIP_DIR_STYLE="bold blue" sudo dnf upgrade --refresh'
    alias install='STARSHIP_DIR_STYLE="bold #FFA500" sudo dnf install'
    alias remove='STARSHIP_DIR_STYLE="bold red" sudo dnf remove'
    ;;
  zypper)
    alias update='STARSHIP_DIR_STYLE="bold blue" sudo zypper refresh && sudo zypper update -y'
    alias install='STARSHIP_DIR_STYLE="bold #FFA500" sudo zypper install'
    alias remove='STARSHIP_DIR_STYLE="bold red" sudo zypper remove'
    ;;
  emerge)
    alias update='STARSHIP_DIR_STYLE="bold blue" sudo emerge --sync && sudo emerge -uDNav @world'
    alias install='STARSHIP_DIR_STYLE="bold #FFA500" sudo emerge'
    alias remove='STARSHIP_DIR_STYLE="bold red" sudo emerge --deselect'
    ;;
  *)
    alias update='echo "Unknown package manager: cannot update"'
    alias install='echo "Unknown package manager: cannot install"'
    alias remove='echo "Unknown package manager: cannot remove"'
    ;;
esac
