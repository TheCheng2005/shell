#!/bin/bash
set -x

############################################
# DSI CONSULTING INC. Project setup script #
############################################
# This script creates standard analysis and output directories
# for a new project. It also creates a README file with the
# project name and a brief description of the project.
# Then it unzips the raw data provided by the client.

if [ -d newproject ]; then
  echo "Recreating the newproject directory"
  rm -rf newproject
fi
mkdir newproject
cd newproject

mkdir analysis output
touch README.md
touch analysis/main.py

# download client data
curl -Lo rawdata.zip https://github.com/UofT-DSI/shell/raw/refs/heads/main/02_activities/assignments/rawdata.zip
unzip -q rawdata.zip

mkdir data

mv rawdata data

cd data

mv rawdata raw

cd ..

mkdir data/processed

mkdir data/processed/server_logs
mkdir data/processed/user_logs
mkdir data/processed/event_logs

mv data/raw/*server* data/processed/server_logs
mv data/raw/*user* data/processed/user_logs
mv data/raw/*event* data/processed/event_logs

rm data/raw/*ipaddr*
rm data/processed/user_logs/*ipaddr*

touch data/inventory.txt
ls data/processed >> data/inventory.txt


###########################################

echo "Project setup is complete!"
