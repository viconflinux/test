# Path to your oh-my-zsh configuration.
ZSH=/home/michael/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
#ZSH_THEME="ditch"
#ZSH_THEME="blinks"
#ZSH_THEME="gentoo"
ZSH_THEME="michael"

# solarized theme
#eval `dircolors ~/.dir_colors/dircolors`
##eval `dircolors ~/.dir_colors/dircolors.ansi-light`
##eval `dircolors ~/.dir_colors/dircolors.256dark`
##eval `dircolors ~/.dir_colors/dircolors.ansi-dark`
##eval `dircolors ~/.dir_colors/dircolors.ansi-universal`

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
#COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(git svn debian dircycle)
#plugins=(debian dircycle)
plugins=(archlinux dircycle)
#plugins=(archlinux dircycle zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
#source $ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# This provides:
# - CTRL-R to do history search with fzf.
# - CTRL-T to find all files/dirs in current dir and its sub-dirs.
# Note that "FZF_ALT_C_COMMAND=" disables the "ALT-C" shortcut.
# See: https://junegunn.github.io/fzf/shell-integration/
FZF_ALT_C_COMMAND= source <(fzf --zsh)

#
# OPTIONS:
#

# Damit funktioniert negieren von folgenden Ausdruecken mittels "^", z.B. foo.^tex findet z.B. foo.aaa foo.ax etc.
setopt extendedglob

# 'ls *' soll auch files/dirs erkennen, die mit einem Punkt starten.
setopt glob_dots

# Statt 'cd ..' oder 'cd foo' reicht '..' bzw. 'foo'.
setopt AUTO_CD

# Automatisch Verzeichnisse auf Stack pushen (statt explizit pushd/popd). dirs -v command zeigt Stack an.
setopt AUTO_PUSHD

# Enable sharing of command history among all running shells.
setopt SHARE_HISTORY

# no autocorrect
unsetopt correct_all

# Don't send SIGHUP to background processes when the shell exits.
setopt nohup


#
# KEY BINDINGS:
#

# Behave like bash: kill everything left of the cursor but not entire line
bindkey \^U backward-kill-line


#
# EXPORTS:
#

export GREP_COLORS='mt=1;31' # red color for grep matches instead of gray

export EDITOR="vim"
export VISUAL=$EDITOR
export SVN_EDITOR=$EDITOR

# ifconfig, route, etc.
export PATH=$PATH:~/bin/
export PATH=$PATH:/sbin/

# java
#export JAVA_HOME=/opt/jvm/jdk1.6.0_45
#export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin


#
# SUFFIX ALIASES:
#

# Suffix aliases
alias -s dvi='xdvi'
alias -s pdf='evince'
#alias -s pdf='QT_QPA_PLATFORMTHEME="qt5ct" okular'
#alias -s png='geeqie'
#alias -s jpg='geeqie'
#alias -s png='eog'
alias -s png='pinta'
#alias -s jpg='eog'
alias -s jpg='pinta'
alias -s odt='libreoffice'
alias -s odg='libreoffice'
alias -s ods='libreoffice'
alias -s pptx='libreoffice'
alias -s ppt='libreoffice'
alias -s doc='libreoffice'
alias -s docx='libreoffice'
alias -s xls='libreoffice'
alias -s xlsx='libreoffice'
alias -s rtf='libreoffice'


#
# ALIASES:
#

#alias vi=vim
alias vi=nvim
alias grep='grep  --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias v='vpn.sh'
alias vpn='vpn.sh'

alias 1='cd ..'
alias 2='cd ../..'
alias 3='cd ../../..'
alias 4='cd ../../../..'
alias 5='cd ../../../../..'
alias 6='cd ../../../../../..'
alias 7='cd ../../../../../../..'
alias 8='cd ../../../../../../../..'
alias 9='cd ../../../../../../../../..'

#
alias a='ls -laqh'
alias bc='bc -l --quiet'
alias df='df -h'
alias top='top -d1'
alias t='top'
alias d='cd ~/Downloads'
alias x='evince'
#alias x='QT_QPA_PLATFORMTHEME="qt5ct" okular'
alias p=pacman
alias cal='cal -m'

alias sudo='sudo '
alias locate='sudo updatedb && locate'

# Safe rm deletes files into ~/.local/share/Trash/
# -> UPDATE: auskommentiert, da Trash zu schnell zu groß wird.
#alias rm='/usr/bin/safe-rm'
#alias trash='cd ~/.local/share/Trash'

#alias find="echo Erinnerung: fd benutzen"
# alias grep="echo Erinnerung: rg statt grep testen"
#alias cat="bat"
alias less="bat"

# Alias "y" for "yazi".
# Change to directory selected in yazi when quitting yazi (from https://yazi-rs.github.io/docs/quick-start/ ) 
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
	a # finally execute alias a (='ls -laqh')
}


# My cd replacement/extension so I can quickly change in
# terminal 2 to the last active directory of terminal 1.
LASTDIR_FILE=~/.zsh_lastdir
cd() {
	if [[ "$1" == "=" ]]; then
		[[ -e $LASTDIR_FILE ]] && builtin cd `head -n1 $LASTDIR_FILE`
	else
		builtin cd "$@" && echo `pwd` > $LASTDIR_FILE
	fi
	if [ $? -eq 0 ]; then
		a # finally execute alias a (='ls -laqh') unless an error occurred before (e.g. 'no such file or directory')
	fi
}
alias 0='cd ='


#
# START SWAY?
#

if test -z "$DISPLAY" && test $(tty) = /dev/tty1; then
    sway
fi

