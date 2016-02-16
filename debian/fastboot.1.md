% FASTBOOT(1) android-platform-system-core | fastboot Manuals
% The Android Open Source Project
% 6.0.1_r16

# NAME

fastboot - Android flashing and booting utility

# SYNOPSIS

**fastboot** [-w] [-u] [-s _device_] [-p _product_] [-c _cmdline_] [-i _vendorId_] [-b _baseAddr_] [-n _pageSize_] [-S _size_[K|M|G]] _command_

# DESCRIPTION

**fastboot** is a command line tool for flashing an Android device, boot an
Android device to fastboot mode, etc..

# OPTIONS

-w
: Erase userdata and cache (and format if supported by partition type).

-u
: Do not erase partition before formatting.

-s _device_
: Specify device serial number or path to device port.

-p _product_
: Specify product name.

-c _cmdline_
: Override kernel commandline.

-i _vendorId_
: Specify a custom USB vendor ID.

-b _baseAddr_
: Specify a custom kernel base address (default: **0x10000000**).

-n _pageSize_
: Specify the nand page size (default: **2048**).

-S _size_[K|M|G]
: Automatically sparse files greater than 'size'. **0** to disable.


# COMMANDS

fastboot update _filename_
: Reflash device from update.zip.

fastboot flashall
: Flash boot, system, vendor, and -- if found -- recovery.

fastboot flash _partition_ [_filename_]
: Write a file to a flash partition.

fastboot flashing lock
: Locks the device. Prevents flashing.

fastboot flashing unlock
: Unlocks the device. Allows flashing any partition except bootloader-related
  partitions.

fastboot flashing lock_critical
: Prevents flashing bootloader-related partitions.

fastboot flashing unlock_critical
: Enables flashing bootloader-related partitions.

fastboot flashing get_unlock_ability
: Queries bootloader to see if the device is unlocked.

fastboot erase _partition_
: Erase a flash partition.

fastboot format[:[_fs type_][:[_size_]] _partition_
: Format a flash partition. Can override the fs type and/or size the bootloader
  reports.

fastboot getvar _variable_
: Display a bootloader variable.

fastboot boot _kernel_ [_ramdisk_ [_second_]]
: Download and boot kernel.

fastboot flash:raw boot _kernel_ [_ramdisk_ [_second_]]
: Create bootimage and flash it.

fastboot devices [-l]
: List all connected devices (with device paths if **-l** is used).

fastboot continue
: Continue with autoboot.

fastboot reboot [bootloader]
: Reboot device [into bootloader].

fastboot reboot-bootloader
: Reboot device into bootloader.

fastboot help
: Show this help message.