1. Set the environment variable of the platform-tools.

Mac or Linux: Add the following line at the end of the file, replacing /path/to/platform-tools with the actual path where you extracted the SDK Platform Tools
```
export PATH="/path/to/platform-tools:$PATH"
```
like : export PATH="/home/remon/Android/Sdk/platform-tools:$PATH"

2. Save the file and exit the text editor. Run the following command to apply the changes:
```
source ~/.bash_profile
```

3. Enable Wireless Debugging from the Developer options.
   Connect your Android device via wire for the first time.
   
4. Connect your Android device and your computer to the same Wi-Fi network.

5. Run this command to check whether everything is installed or not?
```
adb version
```

6. Run this command to check the connected device IP address.
```
adb shell ip route
```

7. Run this command to view the connected device list.
```
adb devices
```

8. If you can see your device? then run this command below.
   adb connect your_device_ip_address:device_port (NOTE: you have seen the IP address in your before commands. The port number you will find on your device's Wireless Debugging settings. also IP address too.)
   
```
adb connect 192.168.0.103:38621
```
