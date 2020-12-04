# ADBoverWiFi

This is a bash script connects Android ADB to your device over Wi-Fi.
To use this script, you need to have the `adb` installed and in your PATH.
When you run this script, it will use `adb` to poll for devices connected to adb on USB and will transition them Wi-Fi.

The following is a sample run:

```
$ ./ADBoverWIFI.sh
ADB over Wi-Fi

 1. Connect the device and the computer to the same Wi-Fi network.
 2. Plug the device to the computer with a USB cable.
 3. Wait for this application to recognize the device.
 4. Wait for this application to initiate: adb tcpip 5555
 5. You can disconnect the USB from the device.
 6. Wait for this application to initiate: adb connect ip_address:5555

[16:29:15] Plug in a device to this computer.
[16:29:15] DEVICE00001: Device plugged in.
[16:29:15] DEVICE00001: Device is on IP address 192.168.43.1.
[16:29:15] DEVICE00001: adb -s DEVICE00001 tcpip 5555
[16:29:15] DEVICE00001: restarting in TCP mode port: 5555
[16:29:15] DEVICE00001: Waiting for WIFI: ..
[16:29:25] DEVICE00001: Device unplugged.
[16:29:25] DEVICE00001: adb connect 192.168.43.1:5555
[16:29:25] DEVICE00001: already connected to 192.168.43.1:5555
[16:29:30] Plug in a device to this computer.
[16:29:40] DEVICE00002: Device plugged in.
[16:29:40] DEVICE00002: Device is on IP address 192.168.43.6.
[16:29:40] DEVICE00002: adb -s DEVICE00002 tcpip 5555
[16:29:40] DEVICE00002: restarting in TCP mode port: 5555
[16:29:40] DEVICE00002: Waiting for WIFI: ..
[16:29:50] DEVICE00002: Device unplugged.
[16:29:50] DEVICE00002: adb connect 192.168.43.6:5555
[16:29:50] DEVICE00002: already connected to 192.168.43.6:5555
[16:29:55] Plug in a device to this computer.
^C
$
```
