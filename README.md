# dotfiles

## Requirements

### Stow

```
$ apt install stow
```

### A Nerd Font patched font (like Fira Code)

```
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip
```

## Installation

clone the dotfiles repo into your $HOME directory

```
$ git clone git@github.com/stubbs28/dotfiles.git
$ cd dotfiles
```

install dependencies
```
$ ./scripts/install_deps.sh
```

use stow to create simlinks

```
$ stow .
```

if you have existing dotfiles, use the adopt flag.

```
$ stow --adopt .
```
