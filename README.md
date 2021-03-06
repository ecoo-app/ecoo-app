# ecoo

https://www.ecoo.ch/de/

## Setup

### Setup Flutter

- install flutter https://flutter.dev/docs/get-started/install (install android studio for android sdk and xcode for ios)

- Install the VS code flutter extension

- Run flutter doctor (View > Comand Palett.. Flutter: Run Flutter Doctor) and resolve all issues.

- To Connect a device run
  `flutter emulators`
  which will list all available emulators. Then choose
  `flutter emulators --launch EMULATOR NAME`
  the selected device is displayed in the VS Code status bar (blue at bottom) and can be changed there
  (download Android Studios / Xcode for emualtors/simulators)

- Go to debugger to run the app (create a launch config file an select dart & flutter)

see section **Run the app** for help: https://flutter.dev/docs/get-started/test-drive?tab=vscode

- install vscode-flutter-i18n-json: i18n generation https://github.com/esskar/vscode-flutter-i18n-json

## Development

- (run `flutter pub get` to install the dependencies) is run automagically
- Go to debugger to run the app (hotreload)

- run `make watch_generate_code` to generate injectables

- use `@Environment(Env.mock)` to annotate mock classes. Use `@Environment(Env.dev)` to annotate dev classes. Use `@Environment(Env.prod)` to annotate prod classes.

### add translation:

- add the translation to the translation files (i18n > [lang].json)
- update the generated translations by opening the VSC command palette and use Flutter I18n Json: Update

### code organisation:

- most of the code is in `ui`. `screens` for ui specific logic (views and view models). `core` for shared logic (services).

- `business` contains entities.

- `data` contains repositories.

### Branching Strategy

This repository uses the GitLab Flow branching strategy.
All branches should be created from master. Create feature or release branches.
