#!/bin/sh
#Source: http://wiki.centos.org/HowTos/EncryptedFilesystem
#License: CC-BY-SA http://creativecommons.org/licenses/by-sa/3.0/

USAGE="`basename $0` [volume name] [volume size in MB]"
VOLUME="$1"
SIZE="$2"
LOOP_DEVICE"/dev/loop0"

# Create an empty file sized to suit your needs. The one created
# in this example will be a sparse file of 8GB, meaning that no
# real blocks are written. Since we will force block allocation
# lateron, it would not make much sense to do this now, since
# the blocks will be rewritten anyway.

dd if="/dev/zero" of="$VOLUME" bs=1M count=0 seek="$SIZE"

# Lock down normal access to the file
chmod 600 "$VOLUME"

# Associate a loopback device with the file
sudo /sbin/losetup "$LOOP_DEVICE" "$VOLUME"

# Encrypt storage in the device. cryptsetup will use the Linux
# device mapper to create, in this case, /dev/mapper/secretfs.
# The -y option specifies that you'll be prompted to type the
# passphrase twice (once for verification).
#Disabled by default, use the LUKS method below
#/sbin/cryptsetup -y create secretfs 

# Or, if you want to use LUKS, you should use the following two
# commands (optionally with additional) parameters. The first
# command initializes the volume, and sets an initial key. The
# second command opens the partition, and creates a mapping
# (in this case /dev/mapper/secretfs).
sudo /sbin/cryptsetup -y luksFormat "$LOOP_DEVICE"
sudo /sbin/cryptsetup luksOpen "$LOOP_DEVICE" "$VOLUME"

# Check its status (optional)
sudo /sbin/cryptsetup status "$VOLUME"

# Now, we will write zeros to the new encrypted device. This
# will force the allocation of data blocks. And since the zeros
# are encrypted, this will look like random data to the outside
# world, making it nearly impossible to track down encrypted
# data blocks if someone gains access to the file that holds
# the encrypted filesystem.
#dd if=/dev/zero of=/dev/mapper/secretfs
# Create a filesystem and verify its status
#mke2fs -j -O dir_index /dev/mapper/secretfs
#tune2fs -l /dev/mapper/secretfs
# Mount the new filesystem in a convenient location
#mkdir /mnt/cryptofs/secretfs
#mount /dev/mapper/secretfs /mnt/cryptofs/secretfs
