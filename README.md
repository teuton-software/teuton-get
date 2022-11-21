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
1. `teutonget search FILTER`. then, search tests.
1. `teutonget download REPONAME:TESTPATH`, download test files.

## Examples

**Example 1: search and download**

* Create config files with `teutonget init`

```
sh-5.2$ teutonget init

==> Creating configuration files
    ✔ Create dir       : /home/quigon/.config/teuton
    ✔ Create file      : /home/quigon/.config/teuton/repos.ini

==> Refreshing active repos
    ✔ Repo teuton.en (10 tests)
    ✔ Repo teuton.es (4 tests)
sh-5.2$
```

* Search test and show details:

```
sh-5.2$ teutonget search usermin
(x3) teuton.es:sistemas.3/scripting/usermin

```

* Download test:

```
sh-5.2$ teutonget download teuton.es:sistemas.3/scripting/usermin

==> Progress [█████████████████████] 100%
==> Download OK
sh-5.2$
```

**Example 2: Locate TEST ID**

Teuton test ID (TESTID) is `REPONAME:TESTPATH`.

![](docs/images/teutonget-search-debian.png)

# Contact

* **Email**: `teuton.software@protonmail.com`

# Documentation

* [Settings](docs/settings.md)
* [Get](docs/get.md)
* [Repository](docs/repo.md)
* [Commands](docs/commands.md)
