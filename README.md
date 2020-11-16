# Nutbox Public Files

## Beaglebone setup

### Requirements on Mac
Can be installed with homebrew:
 - wget
 - xz

### Download image
From: [https://elinux.org/Beagleboard:Latest-images-testing#Debian_10_.28Buster.29_Console](https://elinux.org/Beagleboard:Latest-images-testing#Debian_10_.28Buster.29_Console)
```
wget https://rcn-ee.com/rootfs/bb.org/testing/2020-08-25/buster-console/bone-eMMC-flasher-debian-10.5-console-armhf-2020-08-25-1gb.img.xz
```

### Check the digest
Should be: 05979541937f52a6471597a71a3bbeccd3504c8cdb2d11a0accd0920f5da00f4
```
sha256sum bone-eMMC-flasher-debian-10.5-console-armhf-2020-08-25-1gb.img.xz
```

### Uncompress image
```
xz -d bone-eMMC-flasher-debian-10.5-console-armhf-2020-08-25-1gb.img.xz
```

### Write the image to microSD card

1) Insert the card into the Mac.
2) Find the card using df:
```
df -l
```

3) Unmount the card:
```
sudo diskutil unmountDisk /dev/diskX
```

4) Write the image to the card (be very careful that you have the right disk!):
```
sudo dd bs=1m if=bone-eMMC-flasher-debian-10.5-console-armhf-2020-08-25-1gb.img of=/dev/diskX
```

### Flash Beaglebone
1) Unplug board completely.
2) Insert the microSD card.
3) While holding the button near the microSD card, plug in the board.
4) Keep the button pressed until the lights flash.
5) When the process is complete the board will shut itself down.

### Log in to Beaglebone over SSH
username: debian

password: temppwd

### Run the setup script
```
wget https://raw.githubusercontent.com/tjcrone/nutbox-public/main/setup.sh;sudo /bin/bash setup.sh
```
