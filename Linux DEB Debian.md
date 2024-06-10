# Flutter Linux Release Build on Ubuntu

## .DEB Debian

Install Patchelf

```bash
sudo dnf install patchelf 
```

To compile Flutter desktop app in Linux you would also need to install the following tools:
`Clang`, `CMake`, `git`, `GTK development headers`, `Ninja build`, `pkg-config`, `liblzma-dev`, `libstdc`++-12-dev

Install this package if not installed yet:

```bash
sudo apt-get install clang cmake git ninja-build pkg-config libgtk-3-dev liblzma-dev libstdc++-12-dev
```

## Step 1

Run this command inside Project directory. Package source link : `https://pub.dev/packages/flutter_distributor`.

```bash
dart pub global activate flutter_distributor
```

## Step 2

create a file inside the root directory `distribute_options.yaml`

and add the following content:

- note: this configuration is combined for both Linux DEB and RPM.

```yaml
variables:
  PGYER_API_KEY: "your api key"
output: dist/
releases:
  - name: dev
    jobs:
      - name: release-dev-linux-deb
        package:
          platform: linux
          target: deb
          build_args:
            enable-experiment: records
      - name: release-dev-linux-rpm
        package:
          platform: linux
          target: rpm
          build_args:
            enable-experiment: records
```

## Step 3

create a file inside the Linux directory `linux/packaging/deb/make_config.yaml`

and add the following content:

```yaml
display_name: My App Name # The name of the application
package_name: com.example.app_id # The package name of the application

maintainer:
  name: Remon Ahammad # The name of the maintainer
  email: remonahammad@gmail.com # The email of the maintainer

priority: optional

section: x11

installed_size: 15700

dependencies:
  - mpv

essential: false

icon: linux/assets/logo.png # The path to the icon file

postuninstall_scripts:
  - echo "Sorry to see you go." # The script to run after the application is uninstalled

keywords:
  - BlackShadowSoftware # The keywords for the application
  - My App Name # The keywords for the application

generic_name: My App Name # The generic name of the application

categories: # The categories for the application
  - Development
  - Network

startup_notify: true
```

## Step 4

Run this command to build the Debian package.

```bash
flutter_distributor release --name=dev --jobs=release-dev-linux-deb
```
