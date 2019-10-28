# Ezlisp
Easier Autolisp using package management [Ezinstall](https://github.com/chenbotao828/Ezinstall)

# Install

1. Download this repository
2. Add path of Ezlisp to os environment variable "Ezlisp" 
3. Add path of Ezlisp and Ezlisp/packages to "Option > Support File Search Paths"
4. Add file `preload.lsp` in Ezlisp to AutoCAD's "appload > Startup Suite"

# Usage

## Package management

1. `(install <author>/<repo>)`: Install autolisp package from github 
2. `(uninstall <repo>)`: Uninstall autolisp package 

## Import package

`(import "<repo>/<file>")`

## Preload packages

Add one line `(import "<repo>/<file>")` to packages/loaded