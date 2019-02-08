# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Octopus Kernel for Redmi Note 4/X
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=1
device.name1=mido
device.name2=redmi note 4
device.name3=Redmi Note 4
device.name4=Redmi Note 4x
supported.versions=8.1.0 - 9
'; } # end properties

# shell variables
block=/dev/block/mmcblk0p21;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;


## AnyKernel install
dump_boot;

# begin ramdisk changes

#Add Spectrum
insert_line init.rc 'octopus' after 'import /init.\${ro.zygote}.rc' 'import /init.octopus.rc';

# end ramdisk changes

write_boot;

## end install
