# e_coupon

## Setup Flutter

- install flutter https://flutter.dev/docs/get-started/install (install android studio for android sdk and xcode for ios)

- Install the VS code flutter extension

- Run flutter doctor (View > Comand Palett.. Flutter: Run Flutter Doctor) and resolve all issues. 

- To Connect a device run
``flutter emulators``
which will list all available emulators. Then choose
``flutter emulators --launch EMULATOR NAME``
the selected device is displayed in the VS Code status bar (blue at bottom) and can be changed there
(download Android Studios / Xcode for emualtors/simulators)

- Go to debugger to run the app (create a launch config file an select dart & flutter)

see section **Run the app** for help: https://flutter.dev/docs/get-started/test-drive?tab=vscode

## Development

- run ``flutter pub get`` to install the dependencies
- Go to debugger to run the app (hotreload)

### code organisation:
(angelehnt an clean code)
- ui: ui/presentation layer
- business: business/domain layer
- data: data layer

- components: all custom views and reusable components
- screens: all app screens
- services: handles all network and buisness logic
- (data: for data storage)
- utils: utils

### Branching Strategy
This repository uses the GitLab Flow branching strategy.
All branches should be created from master.

<br/>
<br/>

# A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
