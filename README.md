# TWRP Custom recovery for Philips PicoPix Max PPX620

## Disclaimers:
- Using a custom recovery and/or modding your device may very likely mess up your device in irreversible ways.
- You *will* lose the automatic update functionality.
- It will also void your warrantee.
- I will not responsible for any kind of damage or loss occurred to your device, during or after the installation process. Proceed at your own risk.
- This is my own personal work and has no endorsement from either Philips or Screeneo.
- *If these instructions are not sufficient for you, you should not be doing this.*

## Contents
- [Putting the device in ADB or FastBoot mode](#putting-the-device-in-adb-or-fastboot-mode)
	- [ADB Mode](#adb-mode)
	- [Fastboot Mode](#fastboot-mode)
- [Flashing the custom recovery](#flashing-the-custom-recovery)
- [Compiling](#compiling)



## Putting the device in ADB or FastBoot mode
Requirements
- USB-A to USB-A cable
- Android platform tool (ADB/Fastboot). Grab [here](https://developer.android.com/studio/releases/platform-tools)
- ADB USB Driver. RockChip specific drivers (with precoded VID/PID) are in [here](https://github.com/rockchip-linux/tools/raw/master/windows/DriverAssitant_v4.91.zip), but the reference Google drivers [here](https://developer.android.com/studio/run/win-usb) should also work.
- Some proficiency for installing and using the above. Find one of the many tutorials online.

### ADB Mode
via PPM launcher
1. Click ok 5 times in About > Software Version.
2. Then from the hidden android menu, go to Device Preferences > About and click 10 times on the build number. This is only needed once.
3. Finally go to Developer Options and enable both usb debugging and Internet Adb.
4. Plug in your USB-A to USB-A cable to your PC.
5. Enable USB Settings. This needs to be done after every reboot.
6. A new USB device will pop up on your PC with VID=0x2207 and PID=0x0006. Manually install the USB drivers for "Android ADB Interface".
7. Run `adb devices` at least once; the PPX620 will ask to authenticate the PC, which you should.

via Network
1. Click ok 5 times in About > Software Version.
2. Then from the hidden android menu, go to Device Preferences > About and click 10 times on the build number. This is only needed once.
3. Finally go to Developer Options and enable both usb debugging and Internet Adb.
4. Connect to the PPX620 via `adb connect <ip-address>:5555`

### Fastboot Mode
First, make sure you are connected via ADB. 

1. Run `adb reboot fastboot`
2. Disconnect USB-A cable if it was connected. PPX620 will not reboot when connected
3. PPX620 will reboot, screen will stay black
4. Connect USB-A to USB-A
5. A new USB device will pop up on your PC with VID=0x18D1 and PID=0xD00D. Manually install the USB drivers for "Android Bootloader Interface".
6. Verify you are connected with `fastboot devices`

*Note:* If you get a USB device with VID=0x2207, PID=0x320C, your device is not in Fastboot but in RockUSB mode. Just hold the power button to power off.

## Flashing the custom recovery

1. Build the image yourself as below, or grab a prebuilt image from the [releases page](https://github.com/pvliesdonk/device_philips_ppx620/releases).
2. Put the device in fastboot mode
3. Flash the image 

    fastboot flash recovery recovery.img

4. Boot into the recovery

   *Note:* The PPX620 restores its original recovery on regular system boot.
   - disconnect USB-A and USB-C Power cable
   - long press power until device powers down
   - while pressing recovery button, turn on using power button.
     The recovery button can be accessed by the pinhole closest to the USB-C power connector.
    
Holding the recovery button while pressing power results in Recovery mode when the USB-A is *not* connected, and in RockUSB mode when the USB-A cable *is* connected.

## Compiling

Following packages are needed in Ubuntu:

    sudo apt-get install git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev libgl1-mesa-dev libxml2-utils xsltproc unzip libtinfo5
    
Ubuntu 20.04 install lib32nurses6 where we need version 5, so we make a symlink:

    sudo ln -s /usr/lib/x86_64-linux-gnu/libncursesw.so.6.2 /usr/lib/x86_64-linux-gnu/libncursesw.so.5
    sudo ln -s /usr/lib/x86_64-linux-gnu/libncurses.so.6.2 /usr/lib/x86_64-linux-gnu/libncurses.so.5

Create a working directory

    export BUILD=/home/peter/twrp-omni
    mkdir -p $BUILD

Start with initializing a shallow clonee of the minimal TWRP manifest as follows:
    
    cd $BUILD
    repo init --depth=1 -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-9.0

Then add this github to the local manifest. Create a new file `$BUILD/.repo/local_manifests/ppx620.xml` with the following contents:

    <?xml version="1.0" encoding="UTF-8"?>
    <manifest>
        <project name="pvliesdonk/device_philips_ppx620" path="device/philips/ppx620" remote="github" revision="master" />
        <remove-project name="android_bootable_recovery"/>
        <project name="pvliesdonk/android_bootable_recovery" path="bootable/recovery"  remote="github" revision="android-9.0"/>
    </manifest>

e.g.

    mkdir -p $BUILD/.repo/local_manifests
    cat <<EOT >> $BUILD/.repo/local_manifests/ppx620.xml
    <?xml version="1.0" encoding="UTF-8"?>
    <manifest>
        <project name="pvliesdonk/device_philips_ppx620" path="device/philips/ppx620" remote="github" revision="master" />
        <remove-project name="android_bootable_recovery"/>
        <project name="pvliesdonk/android_bootable_recovery" path="bootable/recovery"  remote="github" revision="android-9.0"/>
    </manifest>
    EOT

Then to sync up:

    repo sync

Then to build:

    cd $BUILD 
    export ALLOW_MISSING_DEPENDENCIES=true 
    . build/envsetup.sh 
    lunch omni_ppx620-eng 
    make recoveryimage
    
The built recovery image can be found in `$BUILD/out/target/product/ppx620/recovery.img`.

