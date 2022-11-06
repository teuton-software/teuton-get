[<<back](../README.md)

# Get

Find and download local or remote test files.

1. [Search](|search)
2. [Info]
3. [Download]

## 1. Search

At first we need to locate the test according to some criterios.

```
teutonget search FILTER
```

Example:

```
❯ teutonget se window
(x3) teuton.en:systems.1/01-windows-conf
(x1) teuton.en:systems.1/04-winserver-conf
(x1) teuton.en:systems.2/01-install-w10-vbox

```

As a result we have a list of tests ordered from highest to lowest value according to the search requirement. In this example, the test with value x3 has greater weight than x1 and therefore appears recommended in the first position.

Ejample:
```
❯ teutonget se script,fvarrui
(x6) teuton.es:sistemas.3/scripting/usermin
(x1) teuton.en:systems.2/01-install-w10-vbox
```

In this example, the filter is form by multiple words separated by commas. As result, will be shown tests that contain word 1 or word 2, or both. And appear in order from highest to lowest according to the number of times these words appear in the test metadata.

## 2. Info

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

## 3. Download

Download teuton test files identified by TESTID. Example:

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
