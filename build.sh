#!/bin/bash

#Define board
read -p "Please select a board(rpi0 or rpicm3+ as default): " BOARD
BOARD=${BOARD:-rpicm3+}

#Download buildroot
BUILDROOT="buildroot-2019.02.2"
echo "Downloading $BUILDROOT ..."
if [ -d "$BUILDROOT" ]; then
    read -p "$BUILDROOT already exist, do you want to redownload it(N/y)? : " redownloadbuildroot
    redownloadbuildroot=${redownloadbuildroot:-N}
    if [ $redownloadbuildroot == "y" ] || [ $redownloadbuildroot == "Y" ]; then
	sudo rm -r "$BUILDROOT"
	wget https://buildroot.uclibc.org/downloads/"$BUILDROOT".tar.gz && tar xvzf "$BUILDROOT".tar.gz && rm "$BUILDROOT".tar.gz
    else
	read -p "Make clean build(N/y)?: " makeclean
	makeclean=${makeclean:-N}
	if [ $makeclean == "y" ] || [ $makeclean == "Y" ]; then
	    cd "$BUILDROOT"
	    make clean
	    cd ..
	fi
    fi
else
    wget https://buildroot.uclibc.org/downloads/"$BUILDROOT".tar.gz && tar xvzf "$BUILDROOT".tar.gz && rm "$BUILDROOT".tar.gz
fi

#Download kubos linux build
echo "Downloading kubos linux build..."
if [ -d "kubos-linux-build" ]; then
    read -p "kubos linux build already exist, do you want to redownload it(N/y)? : " redownloadkubos
    redownloadkubos=${redownloadkubos:-N}
    if [ $redownloadkubos == "y" ] || [ $redownloadkubos == "Y" ]; then
	sudo rm -r kubos-linux-build
	git clone http://github.com/kubos/kubos-linux-build
    fi
else
    git clone http://github.com/kubos/kubos-linux-build
fi

#Copy board files
echo "Copying $BOARD files..."
if [ $BOARD == "rpi0" ]; then
    cp -r rpi0 kubos-linux-build/board/kubos
    cp -r rpi0/"$BOARD"uboot_defconfig kubos-linux-build/configs
elif [ $BOARD == "rpicm3+" ]; then
    cp -r rpicm3+ kubos-linux-build/board/kubos
    cp -r rpicm3+/"$BOARD"uboot_defconfig kubos-linux-build/configs
else
    echo "Board name wrong! $BOARD don't exist."
    exit 1
fi

#Build kubos linux
cd kubos-linux-build
latest_tag=`git tag --sort=-creatordate | head -n 1`
sed -i "s/0.0.0/$latest_tag/g" common/linux-kubos.config
cd ..
echo "Building kubos linux $latest_tag for board: $BOARD..."
cd "$BUILDROOT"
make BR2_EXTERNAL=../kubos-linux-build "$BOARD"uboot_defconfig
make CARGO_TARGET=arm-unknown-linux-gnueabihf
