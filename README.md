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
1. `teutonget refresh`, to refresh repo catalog.
1. `teutonget search FILTER`. then, search tests.
1. `teutonget download REPONAME:TESTPATH`, download test files.

## Examples

**Example 1: search and download**

* Create config files:

```
> teutonget init

==> Creating configuration files
    ✔ Create dir       : /home/quigon/.config/teuton
    ✔ Create file      : /home/quigon/.config/teuton/repos.ini
```

* Refresh repo catalog:

```
> teutonget refresh

==> Refreshing active repos
    ✔ Repo teuton.en (10 tests)
    ✔ Repo teuton.es (4 tests)
```

* Search test:

```
> teutonget search usermin
(x3) teuton.es:sistemas.3/scripting/usermin
```

* Show details:

```
> teutonget info teuton.es:sistemas.3/scripting/usermin

name    : usermin
author  : fvarrui, dvarrui
date    : 2022-11-05
desc    : Usermin. Script para la gestión de usuarios
tags    : script, usuario, crear, consultar, listar, eliminar
files   : INSTALL.md, README.md, bin/docker.run, bin/up_environ.sh, config.yaml, lib/docker/consultar.rb, lib/docker/eliminar.rb, lib/docker/help.rb, lib/docker/listar.rb, lib/docker/nuevo.rb, lib/vm/consultar.rb, lib/vm/eliminar.rb, lib/vm/help.rb, lib/vm/listar.rb, lib/vm/nuevo.rb, start.rb, tt-info.yaml, vagrant/install-software.sh, vagrant/profesor.rb, vm.rb, vm.yaml
```

* Download test:

```
> teutonget download teuton.es:sistemas.3/scripting/usermin

==> Progress [█████████████████████] 100%
==> Download OK
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
