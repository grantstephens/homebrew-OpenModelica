## OpenModelica Homebrew Formula

This is a work in progress. It is currently set to the HEAD but at the last known version to compile of OSX.
There may very well be things that are installed that shouldn't be and so forth, but it is a work in progress and so far been able to reproduce compiling on my own machine and another clean osx and brew install.
Subversion is needed, but causes issues if added as a dependency.
Tests to be written soon.
To install:
```
brew install subversion
brew tap homebrew/science
brew tap homebrew/dupes
brew tap RexFuzzle/OpenModelica
brew install OpenModelica
```

If the install is failing you can try the following to see what is going on:
```
brew install --verbose --debug openmodelica
```
## Head version
The head version can be installed using:
```
brew install openmodelica --head
```
