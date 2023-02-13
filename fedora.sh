#!/bin/bash
echo "Thanks for using Purnab's fedora 'MUST DO!' script"
echo "optimizing dnf......"
echo -e "\nmax_parallel_downloads=10\ndefaultyes=True\nkeepcache=True" >> /etc/dnf/dnf.conf
echo "configuring rpm-fusion and installing media and video codecs"
echo "this may take a while...."
dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
dnf groupupdate core -y
dnf groupupdate sound-and-video -y
dnf distro-sync -y
echo "swapping msa-va-drivers......"
dnf swap mesa-va-drivers mesa-va-drivers-freeworld -y
echo "adding flathub"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo "done!!"
