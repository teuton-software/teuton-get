[<< back](../README.md)

# Repository

Manage repositories: configure and creation.

## Create info

Teuton test files are located into remote machines. Every Teuton test requires
a special info file that acts as manifest or test metadata.

Supose we are on remote machine (Repository host).

* Run `teutonget create-info PATH/TO/TEUTON/TEST/DIR` to create Teuton test info.

Example:
```
❯ teutonget create-info 03-debian-mkdir-command
name? 03-debian-mkdir-command
author? david
date? 2022-08-29
desc? Practice basic commands into Debian host.
tags? practice,basic,command,debian,host
```

Every Teuton test that you want to be downdable, requires test info file (tt-info.yaml).

## Create repository

We need to summarize all our test information into repo info file (tt-repo-yaml).

* Go to your remote repository server host.
* Move to your repository root directory.
* Then run `teutonget create-repo`.

Example:
```
❯ teutonget create-repo

==> Creating repository
    Reading systems.1/01-windows-conf
    Reading systems.1/02-opensuse-conf
    Reading systems.1/03-debian-conf
    Reading systems.1/04-winserver-conf
    Reading systems.2/01-install-w10-vbox
    Reading systems.2/02-debian-basic-configuration
    Reading systems.2/03-debian-mkdir-command
    Created file ./tt-repo.yaml with 7 tests.
```

## Configure remote repository

Finaly we have to configure the new remote repo.

* Go to your local host. Where your will download tests.
* Modify repo config file (`HOME/.config/teuton/repos.ini`)
* Add your new remote repo.

Example:

```
[REPONAME]
description = WRITE REPO DESCRIPTION
URL = https://write.here/your/repo/url
enable = true
```

* Run `teutonget repos` to check configuration.
