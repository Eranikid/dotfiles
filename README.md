# Installation

1. `$ git clone --bare https://github.com/Eranikid/dotfiles ~/.dotfiles/`
2. `$ git --git-dir=~/.dotfiles/ --work-tree=~/ checkout -f`
3. `$ source .bashrc`
4. To be able to push over ssh later: `$ dotfiles remote set-url origin git@github.com:Eranikid/dotfiles`
5. `$ dotfiles config status.showUntrackedFiles no`
6. `$ install.sh`

# Things to do manually:

1. [Import GPG key](#importing-gpg-key)
2. Set wallpaper
3. Set firefox default search engine
4. Install `yay` [TODO automate]

# Importing GPG key

WIP
