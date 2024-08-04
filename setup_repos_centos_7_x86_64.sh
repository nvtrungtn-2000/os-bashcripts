#!/bin/bash
# chmod +x setup_repo_centos_7_x86_64.sh

CENTOS_REPO_FILE="/etc/yum.repos.d/centos.repo"
EPEL_REPO_FILE="/etc/yum.repos.d/epel-release.repo"

CENTOS_BASEURL="http://centos-hcm.viettelidc.com.vn/7/os/x86_64/"
CENTOS_GPGKEY="http://centos-hcm.viettelidc.com.vn/RPM-GPG-KEY-CentOS-7"
EPEL_BASEURL="https://archives.fedoraproject.org/pub/archive/epel/7.9/x86_64/"
EPEL_GPGKEY="https://archives.fedoraproject.org/pub/archive/epel/RPM-GPG-KEY-EPEL"

sudo rm -rf /etc/yum.repos.d/*

CENTOS_REPO_CONTENT="[centos-repo]
name=CentOS 7 Repository
baseurl=${CENTOS_BASEURL}
enabled=1
gpgcheck=1
gpgkey=${CENTOS_GPGKEY}
"

EPEL_REPO_CONTENT="[epel-archive-7.9]
name=Extra Packages for Epel Release 7.9 - \$basearch (Archive)
baseurl=${EPEL_BASEURL}
enabled=1
gpgcheck=1
gpgkey=${EPEL_GPGKEY}
"

echo "${CENTOS_REPO_CONTENT}" | sudo tee ${CENTOS_REPO_FILE} > /dev/null
sudo rpm --import ${EPEL_GPGKEY}
echo "${EPEL_REPO_CONTENT}" | sudo tee ${EPEL_REPO_FILE} > /dev/null

sudo yum clean all
sudo yum makecache
sudo yum repolist

echo "Done !"
