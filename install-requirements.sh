#!/usr/bin/env bash
# This install all requirements
# We cannot use pip for all this because Daniel decided to use some bullshit video converter
#
# Sebastian Elisa Pfeifer, 2017

# Check what OS we are on
source /etc/os-release

# Download the video converter
wget https://github.com/senko/python-video-converter/archive/master.zip

# check for ffmpeg
which ffmpeg >/dev/null 2>&1

if [ $? -ne 0 ]; then
    case "$ID" in
        "ubuntu" | "debian")
            su -c 'apt-get install libav-tools'
            ;;

        "fedora")
            su -c 'dnf install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm'
            su -c 'dnf install http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'
            su -c 'dnf install ffmpeg'
            ;;

        "centos")
        # Untested!
            su -c 'yum install epel-release -y'
            su -c 'yum install ffmpeg'
            ;;
        *)
            echo "Please install ffmpeg!"
            exit 1
    esac
fi

unzip master.zip
cd python-video-converter-master/
su -c 'python setup.py install'
cd ..
rm -rf python-video-converter-master/
rm master.zip

# check for pip
which pip >/dev/null 2>&1

if [ $? -ne 0 ]; then
    echo "Please install pip!"
    exit 1
fi

# install pip requirements
pip install -r requirements.txt