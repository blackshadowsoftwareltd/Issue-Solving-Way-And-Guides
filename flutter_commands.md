link:
https://docs.flutter.dev/reference/flutter-cli

==========================================================================================
Clean Flutter Sdk Pub Cache
`Remove .pubChach directory from Flutter directory`
then run this command in the terminal
`flutter precache`
==========================================================================================

Android Build :

```
flutter build apk --split-per-abi
```

or :

```
flutter build apk --split-debug-info=. --release
```

From Mac:

```
flutter build apk --split-debug-info=. --release && flutter build ios --split-debug-info=. --release
```
