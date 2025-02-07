
# ########################################################################### #
#                          Mount External Drives                              #
# ########################################################################### #
# The script can technically be used to mount and unmount non-external drives,
# but it’s specifically designed to work with external drives based on the assumption
# that the drives will be mounted under /run/media/$USER/ (a common location for 
# external devices in many Linux distributions).
# Requires zfz

# Function that gives fzf dropdrown of all drives found with lzblk and propts 
# for a name of the drive to be mounted at /run/media/UserName/driveName
# Note: If you have files whose paths point to this drive, mkae sure to set
# the drive name to same name otherwise your files won't load.
mount_external() {
    # Ensure fzf is installed
    if ! command -v fzf &> /dev/null; then
        echo " 𐄂 fzf is not installed! Install it first (e.g., sudo apt install fzf)"
        return 1
    fi

    # List available partitions and select one with fzf
    DEVICE=$(lsblk -rpno NAME,SIZE,TYPE | awk '$3=="part" {print $1, "(" $2 ")"}' | fzf --prompt="Select a drive to mount: " | awk '{print $1}')

    # Exit if no device is selected
    if [[ -z "$DEVICE" ]]; then
        echo "𐄂 No device selected!"
        return 1
    fi

    # Get drive label or fallback to device name
    DRIVE_NAME=$(blkid -s LABEL -o value "$DEVICE")
    if [[ -z "$DRIVE_NAME" ]]; then
        DRIVE_NAME=$(basename "$DEVICE")  # Use device name if no label
    fi

    # Prompt for a custom disk name (allowing spaces)
    read "CUSTOM_NAME?Enter a name for the disk (can include spaces): "
    
    # If the user enters a name, use it, else fallback to the detected name
    if [[ -n "$CUSTOM_NAME" ]]; then
        DRIVE_NAME="$CUSTOM_NAME"
    fi

    # Define mount point
    MOUNT_POINT="/run/media/$USER/$DRIVE_NAME"

    # Create the mount directory if it doesn't exist
    sudo mkdir -p "$MOUNT_POINT"

    # Detect filesystem type
    FS_TYPE=$(lsblk -no FSTYPE "$DEVICE")

    # Mount based on filesystem type
    if [[ "$FS_TYPE" == "ntfs" ]]; then
        sudo mount -t ntfs-3g "$DEVICE" "$MOUNT_POINT"
    else
        sudo mount "$DEVICE" "$MOUNT_POINT"
    fi

    # Verify if mount was successful
    if mount | grep -q "$MOUNT_POINT"; then
        echo " ✓ Drive mounted successfully at $MOUNT_POINT"
    else
        echo " 𐄂 Mount failed!"
    fi
}

# Function that gibs fzf dropdown of all mounted external drives
unmount_external() {
    # Ensure fzf is installed
    if ! command -v fzf &> /dev/null; then
        echo " 𐄂 fzf is not installed! Install it first (e.g., sudo apt install fzf)"
        return 1
    fi

    # Get list of mounted partitions that belong to external devices
    MOUNT_POINT=$(mount | grep -E "/dev/sd[b-z][0-9]*" | awk '{print $3}' | fzf --prompt="Select a drive to unmount: ")

    # Exit if no selection is made
    if [[ -z "$MOUNT_POINT" ]]; then
        echo " 𐄂 No drive selected!"
        return 1
    fi

    # Unmount the selected drive
    echo "Unmounting $MOUNT_POINT..."
    sudo umount "$MOUNT_POINT" && echo " ✓ Drive unmounted successfully!" || echo " 𐄂 Failed to unmount!"
}

# ########################################################################### #
#                       Mount External Drives ends                            #
# ########################################################################### #
