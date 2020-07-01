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

- run `flutter pub get` to install the dependencies
- Go to debugger to run the app (hotreload)

- run `flutter pub run build_runner watch --delete-conflicting-outputs` to generate injectables

### add translation:

- add the translation to the translation files (i18n > [lang].json)
- update the generated translations by opening the VSC command palette and use Flutter I18n Json: Update

### code organisation:

#### @Tobi

- Tutorial about flutter clean architecture: https://www.youtube.com/watch?v=KjE2IDphA_U&t=1s
- Change Notifier https://www.youtube.com/watch?v=zKXz3pUkw9A, MVVW pattern https://www.youtube.com/watch?v=kDEflMYTFlk and dependency injection https://www.youtube.com/watch?v=KNcP8z0hWqs&list=PLB6lc7nQ1n4jMy66mxd19YTKUqcAzw3qB&index=17 https://pub.dev/packages/injectable#setup
- Widgets and Layouts https://flutter.dev/docs/development/ui/widgets/material https://flutter.dev/docs/development/ui/widgets
- evaluate gradient widgets for gradient buttons: https://pub.dev/packages/gradient_widgets

#### build after clean code principles

watch Reso Coders tutorial: https://www.youtube.com/watch?v=dc3B_mMrZ-Q&list=PLB6lc7nQ1n4iYGE_khpXRdJkJEp9WOech&index=15 this project similarly is built. Except the Presentation logic is handled with Change Notifier with MVVW pattern instead of BloC similar to this https://www.youtube.com/watch?v=kDEflMYTFlk. And use Injectable on top of get_it https://www.youtube.com/watch?v=KNcP8z0hWqs&list=PLB6lc7nQ1n4jMy66mxd19YTKUqcAzw3qB&index=17 https://pub.dev/packages/injectable#setup

- ui: ui/presentation layer
- business: business/domain layer
- data: data layer

### dart specials

- `new` was made optional beginning with Dart 2.0. We will therfore omit `new`
- Unlike Java, Dart doesn’t have the keywords `public`, `protected`, and `private`. If an identifier starts with an underscore (\_), it’s private to its library.

### Branching Strategy

This repository uses the GitLab Flow branching strategy.
All branches should be created from master.

<br/>
<br/>

## more stuff / interesting stuff

`new` was made optional beginning with Dart 2.0, this is why some examples or tutorial still use `new` and newer or updated ones don't.

automagically i18n https://github.com/esskar/vscode-flutter-i18n-json

mvvm packages https://medium.com/free-code-camp/app-architecture-mvvm-in-flutter-using-dart-streams-26f6bd6ae4b6
https://pub.dev/packages/fmvvm https://pub.dev/packages/mvvm

# A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
