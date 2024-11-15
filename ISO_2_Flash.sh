#!/bin/bash


cat << "EOF"
::::::::::: ::::::::   ::::::::        ::::::::       :::::::::: :::            :::      ::::::::  :::    ::: 
    :+:    :+:    :+: :+:    :+:      :+:    :+:      :+:        :+:          :+: :+:   :+:    :+: :+:    :+: 
    +:+    +:+        +:+    +:+            +:+       +:+        +:+         +:+   +:+  +:+        +:+    +:+ 
    +#+    +#++:++#++ +#+    +:+          +#+         :#::+::#   +#+        +#++:++#++: +#++:++#++ +#++:++#++ 
    +#+           +#+ +#+    +#+        +#+           +#+        +#+        +#+     +#+        +#+ +#+    +#+ 
    #+#    #+#    #+# #+#    #+#       #+#            #+#        #+#        #+#     #+# #+#    #+# #+#    #+# 
########### ########   ########       ##########      ###        ########## ###     ###  ########  ###    ### 

EOF


# Function to display usage
usage() {
    echo "Usage: $0 <USB_MOUNT_POINT> <ISO_FILE>"
    echo "Example: $0 /dev/sdX /path/to/image.iso"
    exit 1
}

# Check if two arguments are provided
if [ "$#" -ne 2 ]; then
    usage
fi

# Assign arguments to variables
USB_MOUNT_POINT="$1"
ISO_FILE="$2"

# Validate ISO file
if [ ! -f "$ISO_FILE" ]; then
    echo "Error: ISO file not found at '$ISO_FILE'"
    exit 1
fi

# Confirm the USB mount point
echo "WARNING: All data on $USB_MOUNT_POINT will be erased."
read -p "Type 'yes' to confirm: " CONFIRMATION
if [ "$CONFIRMATION" != "yes" ]; then
    echo "Operation canceled."
    exit 0
fi

# Unmount the USB drive if mounted
echo "Unmounting $USB_MOUNT_POINT..."
umount "$USB_MOUNT_POINT" 2>/dev/null

# Write the ISO to the USB drive using dd
echo "Writing ISO to USB. This may take some time..."
sudo dd if="$ISO_FILE" of="$USB_MOUNT_POINT" bs=4M status=progress oflag=sync

# Sync to ensure all data is written
sync

echo "Done! The ISO has been written to $USB_MOUNT_POINT."

exit 0
