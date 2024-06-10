# Flutter Linux Release Build on Fedora

## .RPM Red Hat Package Manager

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

create a file inside the Linux directory `linux/packaging/rpm/make_config.yaml`

and add the following content:

```yaml
display_name: My App Name # Change this to your app name.
icon: linux/assets/ag_logo.png # Change this to your app icon.
summary: A Flutter application for Linux. # Change this to your app summary.
group: Applications/Development Tools
vendor: BlackShadowSoftware # Change this to your company name.
packager: Remon Ahammad # Change this to your name.
packagerEmail: remonahammad@gmail.com # Change this to your email.
license: ASL 2.0
url: https://github.com/blackshadowsoftwareltd # Change this to your app repository.

# build_arch: aarch64
BuildArch: noarch

requires:
  - mpv

keywords:
  - API
  - My App Name # Change this to your app name.

generic_name: My App Name # Change this to your app name.

categories: 
  - Development
  - Network # Change this to your app category.

startup_notify: true
```

## Step 4

Run this command to build the RPM package.

```bash
flutter_distributor release --name=dev --jobs=release-dev-linux-rpm
```
