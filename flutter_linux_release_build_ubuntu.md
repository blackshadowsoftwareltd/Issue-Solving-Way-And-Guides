# Flutter Linux Release Build on Ubuntu

## Install dpkg-dev and fakeroot

```bash
sudo dnf install dpkg-dev fakeroot
```

## create a directory & files for the build

```bash
~/linux_app_package
└── linux_app
    ├── DEBIAN
    │   └── control
    └── usr
        └── bin
            ├──
```

## Create the control file (control file has no extension)

```bash
Package: linux-app
Version: 1.0.0
Section: base
Priority: optional
Architecture: amd64
Depends: libgtk-3-0
Maintainer: Your Name dev@remon.com
Description: Company.com
 A Flutter application for Linux.
```

dir name: linux_app,
but package: linux-app

## Copy the Built (bundle file) Files and paste them in the usr/bin directory

`build/linux/x64/release/` to `my_linux_app/usr/bin/`

## Run this command to create the .deb file

```bash
dpkg-deb --build linux_app
```

## Install the .deb file in desired Ubuntu machine

open the terminal and run the following command

```bash
sudo dpkg -i linux-app.deb
```

## Run the Application. Try running your application from the terminal

```bash
linux-app
```

## If not working?

check the executable file is exist in `/usr/bin/bundle/`
check `export PATH=$PATH:/usr/bin/bundle` is added in `~/.bashrc` or `~/.zshrc` file

## Done 🎉
