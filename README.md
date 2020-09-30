# .vim
Personal vim configuration

To properly clone this repo and all its git submodules:
```
git clone --recursive https://github.com/MikiBG/.vim.git
```

## Plugins
* [vim-commentary](https://github.com/tpope/vim-commentary)
* [vim-repeat](https://github.com/tpope/vim-repeat)
* [vim-surround](https://github.com/tpope/vim-commentary)
* [julia-vim](https://github.com/JuliaEditorSupport/julia-vim)


## Management
Use shell scripts to install, update and uninstall third-party 
packages
```
$ ./install_package.sh <repo's URL>
```
```
$ ./remove_package.sh <name>
```
```
$ ./update.sh  # updates all installed plugins
```

More info on how to manage  vim plugins 
[here](https://shapeshed.com/vim-packages/)
