#!/bin/bash
echo "Thanks for using Purnab's fedora 'MUST DO!' script"
echo "Enter new host name: "
read host_name
hostnamectl set-hostname "$host_name"
echo "optimizing dnf......"
echo -e "\nmax_parallel_downloads=10\ndefaultyes=True\nkeepcache=True" >> /etc/dnf/dnf.conf
echo "clearing cache...."
dnf clean all
echo "configuring rpm-fusion and installing media and video codecs"
echo "this may take a while...."
dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm 
dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf groupupdate core
dnf groupupdate sound-and-video
echo "upgrade the system??"
echo "enter(y/n):"
read choice
yes = "y"
no = "n"
if (($choice == $yes))
then
    dnf distro-sync
fi