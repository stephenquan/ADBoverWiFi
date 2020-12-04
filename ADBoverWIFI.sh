#!/bin/bash

intro()
{
  cat <<EOF
ADB over Wi-Fi

 1. Connect the device and the computer to the same Wi-Fi network.
 2. Plug the device to the computer with a USB cable.
 3. Wait for this application to recognize the device.
 4. Wait for this application to initiate: adb tcpip 5555
 5. You can disconnect the USB from the device.
 6. Wait for this application to initiate: adb connect ip_address:5555

EOF
}

adb_get_all_devices()
{
  adb devices | grep "device$" | awk '{print $1}'
}

adb_find_device()
{
  adb devices | grep "device$" | awk '{print $1}' | grep "$1"
}

move_usb_device_to_wifi()
{
  local device=$1
  
  echo "[$(date +%H:%M:%S)] ${device}: Device plugged in."

  addr=$(adb -s ${device} shell ip -o -a -f inet a | grep wlan0 | perl -pe 's/.* inet ([0-9.]*).*/\1/')
  if [ "$addr" == "" ]; then
    echo "[$(date +%H:%M:%S)] ${device}: no IP address found."
    return
  fi
  
  echo "[$(date +%H:%M:%S)] ${device}: Device is on IP address ${addr}."
  echo "[$(date +%H:%M:%S)] ${device}: adb -s "${device}" tcpip 5555"
  echo -n "[$(date +%H:%M:%S)] ${device}: "
  adb -s "${device}" tcpip 5555
  
  echo -n "[$(date +%H:%M:%S)] ${device}: Waiting for WIFI: "
  detect=$(adb_find_device ${device})
  while [ "${detect}" == "${device}" ];
  do
    echo -n "."
    sleep 5
    detect=$(adb_find_device ${device})
  done
  
  echo ""
  echo "[$(date +%H:%M:%S)] ${device}: Device unplugged."
  echo "[$(date +%H:%M:%S)] ${device}: adb connect ${addr}:5555"
  echo -n "[$(date +%H:%M:%S)] ${device}: "
  adb connect ${addr}:5555
}

move_all_usb_device_to_wifi()
{
  prompt_user=1
  while [ 1 == 1 ];
  do
    if ((prompt_user)); then
      echo "[$(date +%H:%M:%S)] Plug in a device to this computer."
      prompt_user=0
    fi
    local devices=($(adb_get_all_devices))
    local device
    for device in ${devices[@]}
    do
      case ${device} in
      emulator*)
        continue
        ;;
      *:*)
        continue
        ;;
      esac

      move_usb_device_to_wifi "${device}"
      prompt_user=1
    done
    sleep 5
  done
}

intro
move_all_usb_device_to_wifi

