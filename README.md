# Kobragen
Docker container and GitHub action for automatically generating routed Gerber files from Ergogen
configurations.

## Dev scripts
The dev scripts must be run from the project root. The available scripts are:
- `./scripts/dev-ergogen.sh`: Builds `example.yaml` and opens it in KiCad
- `./scripts/dev-kobragen.sh`: Builds `example` pcb in `example.yaml`, adds
  routes to it and opens it in KiCad
- `./scripts/watch-ergogen.sh`: Runs `dev-ergogen.sh` when `example.yaml` change
- `./scripts/watch-kobragen.sh`: Runs `dev-kobragen.sh` when `example.yaml` change

### Dependencies
- `KiCad` is required for all scripts
- `inotify-tools` is required for `watch-{ergo, kobra}gen.sh`

## Attribution
The following projects are used to make this project possible:
- [Ergogen](https://github.com/ergogen/ergogen)
- [KiCad](https://gitlab.com/kicad/code/kicad)
- [freerouting_cli](http://repo.hu/projects/freerouting_cli/)
- [KiKit](https://github.com/yaqwsx/KiKit)
- [samoklava](https://github.com/soundmonster/samoklava)
