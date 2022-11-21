
## [0.2.2] - 2022-11-15

- FIX BUG: Advise user when try to read information before create config files.
- Main command: teutonget and teuton-get.

## [0.2.1] - 2022-11-05

- FIX BUG: Create directories when download test with "folder/subfolder/files".

## [0.2.0] - 2022-09-05

- Colors are added to differentiate the repositories.

## [0.1.0] - 2022-08-29

- Initial release

## TODO

- Simplified TESTID. When search, info an download, we need TESTID to uniquely identify one TEST among all. FILTER is not enough. Propose: when FILTER only returns one TEST (REPONAME:PATH) we will use this without requiring TESTID.
- Auto create config files: teuton repos must first check if config files exits. If not then show warning or auto create.
- show last refresh timestamp: Perhaps... teuton [search|info] FILTER could show this last refresh timestamp just to advise user... hey!, it's time to refresh!
- Sanityze text input for YAML content file.
- download como git clone: crear carpeta con el nombre del repo. Si existe advierte del error. O parámetro con un nombre diferente.

