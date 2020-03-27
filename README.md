# Ezlisp
Easier Autolisp using package management [Ezinstall](https://github.com/chenbotao828/Ezinstall)

# Install

1. Download this repository
2. Add path of Ezlisp to os environment variable "Ezlisp" 
3. Add path of Ezlisp and Ezlisp/packages to "Option > Support File Search Paths"
4. Add file `preload.lsp` in Ezlisp to AutoCAD's "appload > Startup Suite"

# Usage

## Package management

### Install autolisp package from github 
`(install <author>/<repo>)`

### Uninstall autolisp package 
`(uninstall <repo>)`

## Import package

`(import "<file>")`

`(import "<repo>/<file>")`

`(import "<foo>")` -> `(import "<foo>/<foo>")`

## Preload packages

Add one line `(import "<repo>/<file>")` to packages/loaded
Or, add packge_name to `__loaded_mods__`

## Test packages

Add packge_name to `__testing_mods__`

## Commands (in CAD)

- ll: reload all files in `__loaded_mods__` and `__testing_mods__`
- tt: test all files in `__testing_mods__`
- ttt: reload and test

# Package Structure

- package_name (folder)
    - package_name.lsp
        + (import "package_name/file1")
        + (import "package_name/file2")
        + ...
    - file1.lsp
    - file2.lsp
    - ...
    - test.lsp
        + (import "package_name/tests/file1")
        + (import "package_name/tests/file2")
        + ...
    - tests (folder)
        + file1.lsp (test_file)
        + file2.lsp (test_file)
