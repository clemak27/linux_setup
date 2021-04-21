# my ArchLinux setup

## Screenshots

### neofetch

![fn](./screenshots/nf.png)

### empty workspace

![empty](./screenshots/empty.png)

### single window

![single](./screenshots/ff.png)

### multiple windows

![mult](./screenshots/mult.png)

### neovim

![neovim](./screenshots/neovim.png)

## What tools I use

- KDE + i3-gaps  
  After trying out KDE and GNOME extensivly, I setteled on using KDE. This mostly came down to the KDE team providing better software and extension support than GNOME, also vastly improved styling options. Nowadays I'm also using i3wm together with KDE for that sweet tiling wm experience. </p>
- polybar  
  Highly customizable status bar. Fits i3wm perfectly imo. </p>
- alacritty  
  Fast GPU accelerated terminal emulator. If used Konsole and Kitty before that and while I kinda miss my ligatures, I enjoy alacritty's speed and simplicity. </p>
- neovim  
  My editor of choice. With (way too many) plugins, I use it for editing all non java/kotlin/android projects I work on in my free time.
- firefox  
  Best browser :)
- fzf  
  A great fuzzy finder that makes finding things easier, especiall ypaired with ripgrep. Great (n)vim support too.
- ranger  
  A terminal file explorer with vim-linke keybinds.
- spotify-tui  
  I'm using spotify since I've my personal collection has grown way too large (especially when you want to put it on your smartphone as well). The spotify desktop app is not (officially) supported on linux. but the combination of spotifyd + spotify-tui definitly is :)

## What's in this repo?

- `dotfiles`  
  Symlinked dotfiles for all the tools I use.
- `firefox`
  Firefox customization
- `logo.png`
  btw
- `other`
  Some file that did'nt really fit into an other folder.
- `plasma`
  KDE Plasma color theme and some othe customization
- `polybar`
  Polybar dotfiles
- `README.md`
  You are reading this :)
- `rofi`
  Rofi dotfiles. I use one menu as app launcher and a second menu to select power options (shutdown, reboot, etc.)
- `screenshots`
  Pretty pictures
- `scripts`
  Scripts that don't really fit anywhere else.
- `setup`
  My (way too convoluted) script that installs the system for me.
- `test`
  Basically a stupid test that check if all pacman packages I want to install during setup actually exist (to prevent typos etc.). When this repo was hosted on gitlab.com I ran this in CI, maybe I will setup a github action for that eventually.

## Why?

I don't know. ¯\_(ツ)_/¯
