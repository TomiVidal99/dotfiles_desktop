#!/bin/bash

DATOS_DISK=/dev/sda1
sudo umount -l -f $DATOS_DISK
sudo ntfsfix $DATOS_DISK
sudo mount $DATOS_DISK
