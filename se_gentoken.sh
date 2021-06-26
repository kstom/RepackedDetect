#!/bin/bash

# -g gen Clienttoken && ServerToken
# -p input packagename
# -s input apk sign md5
# -k input key(by yourself)
packagename="com.village.security.demo"
sign_md5="2A:2D:6D:18:95:33:5A:AA:A4:5E:EC:E5:AE:B0:D9:4A"
key="test"
./serverManager_mac -g -p "$packagename" -s "$sign_md5" -k "$key"

echo "errno: "$?