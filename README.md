# Teuton-Get

[![Gem Version](https://badge.fury.io/rb/teuton-get.svg)](https://badge.fury.io/rb/teuton-get)
![GitHub](https://img.shields.io/github/license/dvarrui/teuton-get)
![Gem](https://img.shields.io/gem/dv/teuton-get/0.2.4)

* Find and download _Teuton Tests_ from remote or local repositories.
* Create _Teuton Test_ repository.

## Installation

First install Ruby, then:

```
gem install teuton-get
```

## Usage

* At first, **create config file**.

```bash
$ teutonget init
==> Creating configuration files
    ✔ Create dir       : /home/quigon/.config/teuton
    ✔ Create file      : /home/quigon/.config/teuton/repos.ini
```

* **Refresh** repo catalog, from time to time:

```bash
$ teutonget refresh
==> Refreshing active repos
    ✔ Repo teuton.en (10 tests)
    ✔ Repo teuton.es (4 tests)
```

* **Search** test related with *usermin*:

```bash
$ teutonget search usermin
(x3) teuton.es:sistemas.3/scripting/usermin
```

* **Show** test info:

```bash
$ teutonget show teuton.es:sistemas.3/scripting/usermin
name    : usermin
author  : fvarrui, dvarrui
date    : 2022-11-05
desc    : Usermin. Script para la gestión de usuarios
tags    : script, usuario, crear, consultar, listar, eliminar
files   : INSTALL.md, README.md, bin/docker.run, bin/up_environ.sh, config.yaml, lib/docker/consultar.rb, lib/docker/eliminar.rb, lib/docker/help.rb, lib/docker/listar.rb, lib/docker/nuevo.rb, lib/vm/consultar.rb, lib/vm/eliminar.rb, lib/vm/help.rb, lib/vm/listar.rb, lib/vm/nuevo.rb, start.rb, tt-info.yaml, vagrant/install-software.sh, vagrant/profesor.rb, vm.rb, vm.yaml
```

* **Download test** `teuton.es:sistemas.3/scripting/usermin`:

```bash
$ teutonget pull teuton.es:sistemas.3/scripting/usermin
==> Progress [██████████████] 100%
==> Download finished
```

**Example:** Locate *TEST_ID* for `debian` related tests.

```bash
$ teutonget se debian
(x04) teuton.en:systems.1/03-debian-conf
(x04) teuton.en:systems.2/02-debian-basic-configuration
(x04) teuton.en:systems.2/03-debian-mkdir-command
(x04) teuton.en:systems.2/04-debian-users-grants
(x04) teuton.en:systems.2/11-debian-custom-installation
```

## Build and install the gem from sources

You can build `teuton-get` Ruby gem from sources following the next steps:

1. Clone the repo and change to its directory:

```bash
git clone https://github.com/teuton-software/teuton-get
cd teuton-get
```

2. Build the gem:

```bash
rake build
```

3. Install newly built gem:
- On GNU/Linux or Mac OS:

```bash
sudo gem install pkg/teuton-get-*.gem
```

- On Windows as `Administrator`:

```bash
gem install pkg\teuton-get-*.gem
```

## Documentation

* [Settings](docs/settings.md)
* [Get](docs/get.md)
* [Repository](docs/repo.md)
* [Commands](docs/commands.md)
