# dotfiles

do NOT dox

## Neat trick:
```bash
git init --bare $HOME/.myconf
alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
config config status.showUntrackedFiles no
```
https://news.ycombinator.com/item?id=11070797
