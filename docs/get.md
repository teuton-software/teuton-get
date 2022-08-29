[<<back](../README.md)

# Get

Find and download local or remote files.

## Search

At first we need to locate the files according to some criterios.

* `teutonget search FILTER` is used to find files with FILTER criterio.

Example:

```
❯ teutonget search debian
(3) teuton.en:en/systems.1/03-debian-conf
(2) teuton.en:en/systems.2/02-debian-basic-configuration
```

## Info

Show info about test. Example:
```
❯ teutonget info teuton.en:systems.1/03-debian-conf

name    : Debian configuration
author  : dvarrui
date    : 2020-09-06
desc    :
tags    : Debian, configuration
files   : README.md, config.yaml, debian.rb, network.rb, start.rb
```

## Download

Download test by TESTID. Example:

```
❯ teutonget download teuton.en:systems.1/03-debian-conf

==> Downloading...
==> File: README.md
==> File: config.yaml
==> File: debian.rb
==> File: network.rb
==> File: start.rb
```

Test files will be downloaded into `systems.1_03-debian-conf` local directory.
