# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.

# texlive
export PATH="/usr/local/texlive/2021/bin/x86_64-linux/:$PATH"

# cmd
alias rm="rm -i"
loveyou()
{
    echo "Love you too."
    sudo shutdown -h now
}
git-acp()
{
    git add .
    git commit -m "$1"
    git push -u origin master

}
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
ntpupdate()
{
    sudo ntpdate sg.pool.ntp.org
}
liveclock()
{
    while true; do echo -ne "`date`\r"; done
}

# dynamic fonts
alias font="printf '\e]710;%s\007'"

alias Tamzen-9=Tamzen5x9r
alias Tamzen5x9r='font -misc-tamzen-medium-r-normal--9-65-100-100-c-50-iso8859-1'
alias Tamzen5x9b='font -misc-tamzen-bold-r-normal--9-65-100-100-c-50-iso8859-1'

alias Tamzen-12=Tamzen6x12r
alias Tamzen6x12r='font -misc-tamzen-medium-r-normal--12-87-100-100-c-60-iso8859-1'
alias Tamzen6x12b='font -misc-tamzen-bold-r-normal--12-87-100-100-c-60-iso8859-1'

alias Tamzen-13=Tamzen7x13r
alias Tamzen7x13r='font -misc-tamzen-medium-r-normal--13-101-100-100-c-70-iso8859-1'
alias Tamzen7x13b='font -misc-tamzen-bold-r-normal--13-101-100-100-c-70-iso8859-1'

alias Tamzen-14=Tamzen7x14r
alias Tamzen7x14r='font -misc-tamzen-medium-r-normal--14-101-100-100-c-70-iso8859-1'
alias Tamzen7x14b='font -misc-tamzen-bold-r-normal--14-101-100-100-c-70-iso8859-1'

alias Tamzen-15=Tamzen8x15r
alias Tamzen8x15r='font -misc-tamzen-medium-r-normal--15-108-100-100-c-80-iso8859-1'
alias Tamzen8x15b='font -misc-tamzen-bold-r-normal--15-108-100-100-c-80-iso8859-1'

alias Tamzen-16=Tamzen8x16r
alias Tamzen8x16r='font -misc-tamzen-medium-r-normal--16-108-100-100-c-80-iso8859-1'
alias Tamzen8x16b='font -misc-tamzen-bold-r-normal--16-108-100-100-c-80-iso8859-1'

alias Tamzen-20=Tamzen10x20r
alias Tamzen10x20r='font -misc-tamzen-medium-r-normal--20-145-100-100-c-100-iso8859-1'
alias Tamzen10x20b='font -misc-tamzen-bold-r-normal--20-145-100-100-c-100-iso8859-1'

#emacsclient
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"                  # $EDITOR opens in terminal
export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI mode
alias cdir='source cdir.sh'
