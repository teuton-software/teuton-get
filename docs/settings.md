[<< back](../README.md)

# Settings

* `teutonget init`, the first time it is necessary to run this command to create the configuration files. From now on you can use the tool.

```
==> Creating configuration files
    ✔ Create dir       : /home/quigon/.config/teuton
    ✔ Create file      : /home/quigon/.config/teuton/repos.ini

==> Refreshing active repos
    Repo teuton.en (6 tests)
    Repo teuton.es (2 tests)
```

> Config files are saved into `HOME/.config/teuton` folder.

* `teutonget repos` will show repositories list.

```
Repository list
+-+---------+------------------------------------+
|E|NAME     |DESCRIPTION                         |
+-+---------+------------------------------------+
|✔|teuton.en|Main Teuton repo                    |
|✔|teuton.es|Repositorio principal de Teuton Test|
+-+---------+------------------------------------+
Config: /home/quigon/.config/teuton/repos.ini
```

> Repositories are configured into HOME/.config/teuton/repos.ini

* `teutonget refresh`, from time to time it is advisable to refresh the information of the repositories using this command.

```
==> Refreshing active repos
    Repo teuton.en (6 tests)
    Repo teuton.es (2 tests)
```
