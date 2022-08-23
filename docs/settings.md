[<< back](../README.md)

# Settings

* `teutonget init`, the first time it is necessary to run this command to create the configuration files. From now on you can use the tool.

```
Creating configuration files
 => Create dir       : /home/david/.config/teuton
 => Create file      : /home/david/.config/teuton/repos.ini

Refreshing active repos
 => Refresh repo teuton-en (6)
 => Refresh repo teuton-es (2)
```

> Config files are saved into `HOME/.config/teuton` folder.

* `teutonget repos` will show repositories list.

```
Repository list
+---+-----------+---------------------------------+
| E | NAME      | DESCRIPTION                     |
+---+-----------+---------------------------------+
|   | teuton-en | Main Teuton repo                |
|   | teuton-es | Repositorio principal de Teuton |
+---+-----------+---------------------------------+
Config: /home/david/.config/teuton/repos.ini
```

> Repositories are configured into HOME/.config/teuton/repos.ini

* `teutonget refresh`, from time to time it is advisable to refresh the information of the repositories using this command.

```
Refreshing active repos
 => Refresh repo teuton-en (6)
 => Refresh repo teuton-es (2)
```
