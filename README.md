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
5. Add keyboard layouts in GNOME control center

# Importing GPG key

## If available as file:
`$ gpg --import private-key.asc`

## If available as QR code photo:
1. Import public key from keyserver: `$ gpg -recv-keys 9758268F5917D051187BBE6FA84EC160A129237E`
2. Export public key as file: `$ gpg --output public-key.asc --export user-id 9758268F5917D051187BBE6FA84EC160A129237E`
3. Combine private and public key: `$ zbarimg -1 --raw -Sbinary secret-key.png | paperkey --pubring public-key.asc | gpg --import`
