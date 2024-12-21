#!/bin/bash
# Run `bash build.sh` to update and start a micro-ros agent.

cd build
rm -rf *
# cmake -DPICO_BOARD=pico_w ..
cmake ..
make 
cd ..

echo "Please hold the BOOTSEL button down on Pico and plugin the USB cable into your computer."
read -p "Continue? (Y/N): " confirm 
if [[ "$confirm" != [yY] && "$confirm" != [yY][eE][sS] ]]; then 
    exit 1
fi

cp ./build/*.uf2 /media/hda-humble/RPI-RP2
sleep 5

snap interface serial-port
sudo micro-ros-agent serial --dev /dev/ttyACM0 baudrate=115200

