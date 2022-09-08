#!/bin/bash
set -e

LOOP=$(losetup --find --partscan --show ./steamos_image/disk.img)
mkdir -p ./steamos
mount ${LOOP}p3 ./steamos
unmountimg() {
    umount ./steamos
    losetup -d $LOOP
}
trap unmountimg ERR

docker build -t ghcr.io/d3fau4/holo-base:latest .

unmountimg
