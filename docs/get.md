[<<back](../README.md)

# Get

Find and download local or remote test files.

1. [Search](#1-search)
2. [Show](#2-show)
3. [Download](#3-download)

## 1. Search

At first we need to locate the test according to some criterios.

```
teutonget search FILTER
```

| Command               | Description |
| --------------------- | ----------- |
| teutonget search TEXT | Find test that contains TEXT |
| teutonget search :TEXT | |
| teutonget search ALL:TEXT | |
| teutonget search TEXT1,TEXT2 | Find test that contains TEXT1 or TEXT2 |
| teutonget search REPONAME:TEXT | Find test from REPONAME, that contains TEXT f|
| teutonget search REPONAME:ALL | Find all test from REPONAME |

Example:

```
❯ teutonget search window
(x3) teuton.en:systems.1/01-windows-conf
(x1) teuton.en:systems.1/04-winserver-conf
(x1) teuton.en:systems.2/01-install-w10-vbox

```

As a result we have a list of tests ordered from highest to lowest value according to the search requirement. In this example, the test with value x3 has greater weight than x1 and therefore appears recommended in the first position.

Ejample:
```
❯ teutonget search script,fvarrui
(x6) teuton.es:sistemas.3/scripting/usermin
(x1) teuton.en:systems.2/01-install-w10-vbox
```

In this example, the filter is form by multiple words separated by commas. As result, will be shown tests that contain word 1 or word 2, or both. And appear in order from highest to lowest according to the number of times these words appear in the test metadata.

## 2. Show

Show info about test. Example:

```
❯ teutonget show teuton.en:systems.1/03-debian-conf

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
❯ teutonget pull teuton.en:systems.1/03-debian-conf

==> Downloading...
==> File: README.md
==> File: config.yaml
==> File: debian.rb
==> File: network.rb
==> File: start.rb
```

Test files will be downloaded into `systems.1_03-debian-conf` local directory.
