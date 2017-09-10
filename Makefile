# Kenwood USB stick work flow.
#
# Required tools:
#   sox     - sound eXchange for splitting long files.
#   rename  - Larry Wall's rename program (also called prename).
#   FLAC    - Using flac encoding here.
#   


#
#
#
USB_DEVICE = /dev/sdd1
VOLUME = td128


######################################################################
######################################################################
######################################################################
#
# Set up Music files for the player.
# 
######################################################################

.PHONEY: all
all:
	$(MAKE) prep
	$(MAKE) check-flac
	$(MAKE) copy
.PHONEY: prep
prep:
	$(MAKE) fix-names
	$(MAKE) fix-length

.PHONEY: copy
copy:
	$(MAKE) format-usb
	$(MAKE) mount
	$(MAKE) copy-files

#
# Rename files and folders to be alpha numeric
#
.PHONEY: fix-names
fix-names :
	rename -v 's/[^a-zA-Z_0-9\.\/]+/_/g' ./Music/*
	rename -v 's/[^a-zA-Z_0-9\.\/]+/_/g' ./Music/*/*
	rename -v 's/[^a-zA-Z_0-9\.\/]+/_/g' ./Music/*/*/*


#
# Split flac files that are more that 20min long.
# Player crashes on long FLAC files.
# First use -c to check for long files.
# Then run with splitting if needed.
#
.PHONEY: fix-length
fix-length:
	cd ./Music; \
	../trim-audio

#
# Check FLAC files. FLAC errors cause the player to crash.
#
.PHONEY: check-flac
check-flac:
	find ./Music -name "*.flac" -exec flac -wst '{}' \;



######################################################################
######################################################################
######################################################################
#
# Build the USB partition and file system.
#
######################################################################
#
# BE CAREFUL HERE. 
# DON'T PARTITION OR FORMAT THE WRONG DRIVE!!
# CHECK WHICH DRIVE YOU ARE WORKING WITH.
# GET HELP WITH THIS IF YOU DON'T KNOW WHAT YOU ARE DOING!!!
#
# In this example my system sets the USB drive to /dev/sdd
# "ls /dev" with and without USB inserted to be sure of device name.
#
# USE EXTREME CARE!
#
######################################################################

#
# Partition drive
# You want Win95 FAT32 at offset 1024
# (My commands are in parens, yours may differ slightly)
# (Use "m" for menu)
#
### sudo fdisk /dev/sdd
###    Create primary partition. (n, p)
###    Change partition type to Win95 FAT32 - not LBA (t, l, b)
###    Move offset to 1024 (x, b, 1, 1024)
###    Return to main menu (r)
###    Print Partition (p)
###    Write table and exit (w)


#
# format FAT32 file system.
#
.PHONEY: format-usb
format-usb:
	sudo mkfs.vfat -v -F 32 -n $(VOLUME) $(USB_DEVICE)


#
# Create /media volume name dir
#
/media/$(VOLUME):
	sudo mkdir -p -m 777 /media/$(VOLUME)

#  
# Mount usb to /media/<DRIVE_NAME>
#
.PHONEY: mount
mount:
	pmount $(USB_DEVICE) $(VOLUME)


#
# Copy files on USB in sorted order.
# It's ok to add other dirs or dir levels as input to tar.
# Using * names to get sorted order.
#  
.PHONEY: copy-files
copy-files: /media/$(VOLUME)
	tar -cv Music/*/*/*.flac | tar -C /media/$(VOLUME) -xv

#
# 
#
.PHONEY: unmount
unmount:
	pumount $(VOLUME)
