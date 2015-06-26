#!/bin/bash

# check OS
case "$OSTYPE" in
  darwin*)
   echo "OSX found ..."
   # install curl first
   sudo port install php5-curl
   echo "Installing brew .... "
   ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
   brew doctor
   echo "Updating brew .... "
   brew update

   brew install libsndfile
   brew link --overwrite libsndfile
   brew install git
   echo "Updating port..."
   sudo port -v selfupdate
   echo "Installing ffmpeg..."
   brew install ffmpeg   
   # sudo port install ffmpeg +gpl +postproc +lame +theora +libogg +vorbis +xvid +x264 +a52 +faac +faad +dts +nonfree   
   echo "Installing eSpeak..."
   brew install espeak
   echo "Installing Python..."
   brew install python --universal --framework
   ;;
  linux*)
   echo "LINUX found ... "
   # install ruby, curl, git
   sudo apt-get install ruby-full curl git
   # install dependencies
   sudo apt-get install build-essential m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev
   echo "Installing ffmpeg..."
   sudo add-apt-repository ppa:mc3man/trusty-media
   sudo apt-get update
   sudo apt-get install ffmpeg gstreamer0.10-ffmpeg
   sudo apt-get install x264
   echo "Installing eSpeak..."
   sudo apt-get install espeak
   echo "Installing Python..."
   sudo apt-get install python
   sudo apt-get install python-dev python-setuptools libsndfile-dev
   ;;
  *)        echo "unknown: $OSTYPE" ;;
esac


echo "Installing ez_setup .... "
curl https://bootstrap.pypa.io/ez_setup.py -o - | sudo python

echo "Installing BeautifulSoup .... "
sudo easy_install BeautifulSoup

echo "Installing lxml .... "
sudo easy_install lxml

echo "Installing numpy .... "
sudo easy_install numpy

echo "Installing scikits.audiolab .... "
sudo easy_install scikits.audiolab

echo "Installing pip .... "
sudo easy_install pip

# remove directory if already present, git won't clone to already existing directory
rm -rf aeneas
echo "Clonning aeneas from git .... "
git clone https://github.com/readbeyond/aeneas.git
echo "Entering directory .... "
cd aeneas
echo "Installing aeneas .... "
pip install -r requirements.txt
echo "Checking dependencies .... "
python check_dependencies.py
echo "Leaving directory .... "
cd ..

