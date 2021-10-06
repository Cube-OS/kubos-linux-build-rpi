Kubos linux build for raspberry pi boards, currently support rpi0, rpi0w, rpicm3 and rpicm3+(tested working on vagrant Kubos SDK, ubuntu 18.04 and 20.04).

1. Follow this link(https://docs.kubos.com/1.20.0/getting-started/local-setup.html) to install all the required dependencies and verify everything is installed correctly and working(note: the rust target must be installed in the toolchain you going to use.).

2. Run rustup show to check toolchain and target(arm-unknown-linux-gnueabihf), if not run(rustup target install arm-unknown-linux-gnueabihf)

3. Download this repo(git clone https://github.com/Cube-OS/kubos-linux-build-rpi).

4. CD into the folder(cd kubos-linux-board-rpi).

5. Run build script(./build.sh)

6. Select the board(type in rpi0 for rpi0 or rpi0w, type in rpicm3+ or just hit enter for rpicm3 or rpicm3+).

7. If it's not the first build, the script will ask you whether you want to start from fresh or make clean build.

8. To add custom softwares or libs(cd buildroot-2019.02.2; make menuconfig then after the selection run make CARGO_TARGET=arm-buildroot-linux-gnueabihf) skip this if no need.

9. DD the sdcard.img located in buildroot-2019.02.2/output/image into an sd card.

10. You may want to expend the partition at this stage, the sdcard.img is the minimal size.


PS: 

		May need to install(sudo apt-get install texinfo)
	
		May need to patch 0005-Avoid-printing-null-strings.patch
	
		To activate I2c, SPI, UART see activate buses (bus activation after boot)

**Patch instructions:**
	
	- Start build
	
	- wait for build to fail
	
	- cd ./buildroot-2019.02.2/output/build/host-libglib2-2.56.3/gio/
	
	- change gdbusauth.c and gdbusmessage.c as shown in 0005-Avoid-printing-null-strings.patch
