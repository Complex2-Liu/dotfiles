#!/usr/bin/env bash

set -eu
set -o pipefail

source "$HOME/dotfiles/utils/log"

option=""
package=""

[ $# -ne 2 ] && error "Please provide exactly 2 positional parameters."

case "$1" in
    "-i")
        option="install"
        ;;
    "-d")
        option="uninstall"
        ;;
    *)
        error "invalid option: $1"
        ;;
esac
package="$2"

##############################################################################
# Package-specific installation/uninstallation functions
##############################################################################

# Package: git
function install_git()
{
    if [ -e "$XDG_CONFIG_HOME/git" ]; then
        warn "'$XDG_CONFIG_HOME/git' already exists; you may want to remove it first."
        exit 0
    else
        ln -sfT --verbose "$HOME/dotfiles/git" "$XDG_CONFIG_HOME/git"
    fi
}
function uninstall_git()
{
    if [ -L "$XDG_CONFIG_HOME/git" ]; then
        rm --verbose "$XDG_CONFIG_HOME/git"
    else
        warn "Package git has not been installed yet."
        exit 0
    fi
}

# Package: bin
function install_bin()
{
    if [ ! -d "${HOME}/.local/bin" ]; then
        warn "'${HOME}/.local/bin' doesn't exist, you may want to create it first."
        exit 0
    fi
    for file in "$HOME/dotfiles/bin"/*; do
        ln -sfT --verbose $file "${HOME}/.local/bin/$(basename $file)"
    done
}
function uninstall_bin()
{
    for file in "$HOME/dotfiles/bin"/*; do
        if [ -L "${HOME}/.local/bin/$(basename $file)" ]; then
            rm --verbose "${HOME}/.local/bin/$(basename $file)"
        else
            warn "'${HOME}/.local/bin/$(basename $file)' not found."
        fi
    done
}

##############################################################################
# Install/uninstall packages
##############################################################################

function install()
{
    case $1 in
        "git") install_git ;;
        "bin") install_bin ;;
        *) error "Unknown package: $1" ;;
    esac
}

function uninstall()
{
    case $1 in
        "git") uninstall_git ;;
        "bin") uninstall_bin ;;
        *) error "Unknown package: $1" ;;
    esac
}

case $option in
    "install")
        info "Start installing package $(tput setaf 6)${package}$(tput sgr0)..."
        install $package
        info "DONE"
        ;;
    "uninstall")
        info "Start uninstalling package $(tput setaf 6)${package}$(tput sgr0)..."
        uninstall $package
        info "DONE"
        ;;
esac
