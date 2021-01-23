#
# zshrc
#
# filename: zshrc
# author:   Takashi Makimoto <mackie@beehive-dev.com>
#

#
# General
#

## terminal
export TERM='xterm-256color'

## editor
export EDITOR='vim'
export VISUAL='vim'

## locale
export LANG=ja_JP.UTF-8
export LC_TYPE=ja_JP.UTF-8

## tty
export GPG_TTY=$(tty)

## colors
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS

#
# Framework & Plug-in settings
#

## chpwd
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max     500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file    "${ZDOTDIR}/.chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd   true

## setup 'prezto'
if [[ -s "${HOME}/.prezto/init.zsh" ]];then
  source "${HOME}/.prezto/init.zsh"
fi
if [[ -f "${XDG_CONFIG_HOME}/zsh/.p10k.zsh" ]]; then
  source "${XDG_CONFIG_HOME}/zsh/.p10k.zsh"
fi

## editor
bindkey -M viins 'jk' vi-cmd-mode

#
# aliases
#

alias vi='vim'
alias ll='ls -lhv'

#
# Post processing
#

typeset -gU cdpath fpath mailpath path
