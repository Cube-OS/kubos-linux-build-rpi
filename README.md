Kubos linux build for raspberry pi boards, currently support rpi0, rpi0w, rpicm3 and rpicm3+(tested both working on vagrant Kubos SDK and ubuntu 18.04).

1. Follow this link(https://docs.kubos.com/1.20.0/getting-started/local-setup.html) to install all the required dependencies and verify everything is installed correctly and working(note: the rust target must be installed in the toolchain you going to use.).

2. Download this repo(git clone https://bitbucket.org/CUAVA/kubos-linux-board-rpi).

3. CD into the folder(cd kubos-linux-board-rpi).

4. Run build script(./build.sh)

5. Select the board(type in rpi0 for rpi0 or rpi0w, type in rpicm3+ or just hit enter for rpicm3 or rpicm3+).

6. If it's not the first build, the script will ask you whether you want to start from fresh or make clean build.

7. To add custom softwares or libs(cd buildroot-2019.02.2; make menuconfig) skip this if no need.

8. DD the sdcard.img located in buildroot-2019.02.2/output/image into an sd card.

9. You may want to expend the partition at this stage, the sdcard.img is the minimal size.