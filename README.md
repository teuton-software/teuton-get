
# Teuton-Get

* Find and download _Teuton Tests_ from remote or local repositories.
* Create _Teuton Test_ repository.

![logo](./docs/images/logo.png)

# Installation

1. Install Ruby on your system.
1. `gem install teuton-get`, to install **teuton-get** gem.

# Use

* At first, create config file with `teutonget init`.
* Then, search tests with `teutonget search FILTER`. Example: `teutonget search linux`, will show a list with "linux" related tests.


* `teutonget download REPONAME:TESTPATH`

## Example

```bash
❯ teutonget search conf    
(x3) teuton.en:systems.1/01-windows-conf
(x3) teuton.en:systems.1/02-opensuse-conf
(x3) teuton.en:systems.1/03-debian-conf
(x3) teuton.en:systems.1/04-winserver-conf
(x2) teuton.en:systems.2/01-install-w10-vbox
(x2) teuton.en:systems.2/02-debian-basic-configuration

❯ teutonget download teuton.en:systems.1/02-opensuse-conf
==> Downloading systems.1/02-opensuse-conf from teuton.en...
==> File: README.md 
==> File: config.yaml 
==> File: network.rb 
==> File: opensuse.rb 
==> File: start.rb 
==> File: tt-info.yaml
```

# Contact

* **Email**: `teuton.software@protonmail.com`

# Documentation

* [Settings](docs/settings.md)
* [Get](docs/get.md)
* [Repository](docs/repo.md)
* [Commands](docs/commands.md)
