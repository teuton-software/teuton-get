[![Gem Version](https://badge.fury.io/rb/teuton-get.svg)](https://badge.fury.io/rb/teuton-get)

# Teuton-Get

* Find and download _Teuton Tests_ from remote or local repositories.
* Create _Teuton Test_ repository.

![logo](./docs/images/logo.png)

# Installation

1. Install Ruby on your system.
1. `gem install teuton-get`, to install **teuton-get** gem.

# Use

1. `teutonget init`, at first, create config file.
1. `teutonget search FILTER`. then, search tests. Example: `teutonget search linux`, will show a list with "linux" related tests.
1. `teutonget download REPONAME:TESTPATH`, download test files.

## Example

* Search test and show details:

![](docs/images/teutonget-info.png)

* Download test:

![](docs/images/teutonget-download.png)


# Contact

* **Email**: `teuton.software@protonmail.com`

# Documentation

* [Settings](docs/settings.md)
* [Get](docs/get.md)
* [Repository](docs/repo.md)
* [Commands](docs/commands.md)
