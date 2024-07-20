#!/bin/sh
# create a 1.44M floppy image containing the kernel and command interpreter
# requires Mtools

IMAGE=edrdos.img
LABEL=EDR-DOS

dd if=/dev/zero of=$IMAGE bs=512 count=2880
mformat -i $IMAGE -v $LABEL
dd if=bootsect.144 of=$IMAGE bs=512 count=1 conv=notrunc
mmd -i $IMAGE ::/license
mcopy -i $IMAGE ../dist/drbio.sys ::/
mcopy -i $IMAGE ../dist/drdos.sys ::/
mcopy -i $IMAGE ../dist/command.com ::/
mcopy -i $IMAGE ../dist/country.sys ::/
mcopy -i $IMAGE ../dist/sys.com ::/
mcopy -i $IMAGE ../dist/license/gpl.txt ::/license/
mcopy -i $IMAGE ../license.htm ::/license/
mcopy -i $IMAGE dconfig.sys ::/
mcopy -i $IMAGE dauto.bat ::/

# copy additional files from the files subdirectory
if [ -d files ]; then
	mcopy -i $IMAGE -s -o files/* ::/
fi
