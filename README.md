# e_coupon

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

- run `flutter pub run build_runner watch --delete-conflicting-outputs` to generate injectables

- use `@Environment(Env.mock)` to annotate mock classes. Use `@Environment(Env.dev)` to annotate dev classes. Use `@Environment(Env.prod)` to annotate prod classes.

### add translation:

- add the translation to the translation files (i18n > [lang].json)
- update the generated translations by opening the VSC command palette and use Flutter I18n Json: Update

### more

- gradient widgets https://github.com/bluemix/gradient-widgets

### code organisation:

build after clean code principles

- device: device specific layer
- ui: ui/presentation layer (mvvm)
- - screens: ui screens & view models
- - shared: shared widgets & layouts
- - core: shared abstract classes and router
- business: business/domain layer
- - entities: business logic entities
- - use_cases: uses cases (each use case handles one business logic functionality)
- - repo_definitions: abstract repo classes
- - core: shared stuff
- data: data layer
- - repo_impl: repo implementations
- - data_source
- - model
- core: shared things for all layers: failure and errors (maybe rename?)

### dart specials

- `new` was made optional beginning with Dart 2.0. We will therfore omit `new`
- Unlike Java, Dart doesn’t have the keywords `public`, `protected`, and `private`. If an identifier starts with an underscore (\_), it’s private to its library.

### Branching Strategy

This repository uses the GitLab Flow branching strategy.
All branches should be created from master. Create feature or release branches.

<br/>
<br/>

## more stuff / interesting stuff

automagically i18n https://github.com/esskar/vscode-flutter-i18n-json

mvvm packages https://medium.com/free-code-camp/app-architecture-mvvm-in-flutter-using-dart-streams-26f6bd6ae4b6
https://pub.dev/packages/fmvvm https://pub.dev/packages/mvvm
