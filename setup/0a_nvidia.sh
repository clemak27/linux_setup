#!/bin/bash

rpm-ostree install \
  xorg-x11-drv-nvidia \
  akmod-nvidia
rpm-ostree kargs --append-if-missing=rd.driver.blacklist=nouveau --append-if-missing=modprobe.blacklist=nouveau --append-if-missing=nvidia-drm.modeset=1
