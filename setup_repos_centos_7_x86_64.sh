#!/bin/bash
# chmod +x setup_repo_centos_7_x86_64.sh

CENTOS_REPO_FILE="/etc/yum.repos.d/centos.repo"
EPEL_REPO_FILE="/etc/yum.repos.d/epel-release.repo"
NAGIOS_REPO_FILE="/etc/yum.repos.d/nagios.repo"
NAGIOSXI_DEPS_REPO_FILE="/etc/yum.repos.d/nagiosxi-deps.repo"

CENTOS_BASEURL="http://centos-hcm.viettelidc.com.vn/7/os/x86_64/"
CENTOS_GPGKEY="http://centos-hcm.viettelidc.com.vn/RPM-GPG-KEY-CentOS-7"
EPEL_BASEURL="https://archives.fedoraproject.org/pub/archive/epel/7.9/x86_64/"
EPEL_GPGKEY="https://archives.fedoraproject.org/pub/archive/epel/RPM-GPG-KEY-EPEL"
NAGIOS_BASEURL="https://repo.nagios.com/nagios/7/"
NAGIOSXI_DEPS_BASEURL="https://repo.nagios.com/nagiosxi-deps/7/"
NAGIOS_GPGKEY_V3="https://repo.nagios.com/GPG-KEY-NAGIOS-V3"
NAGIOS_GPGKEY_V2="https://repo.nagios.com/GPG-KEY-NAGIOS-V2"

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

NAGIOS_REPO_CONTENT="[nagios-repo]
name=Nagios 7 Repository
baseurl=${NAGIOS_BASEURL}
enabled=1
gpgcheck=1
gpgkey=${NAGIOS_GPGKEY_V3}
"

NAGIOSXI_DEPS_REPO_CONTENT="[nagiosxi-deps-repo]
name=Nagios XI Dependencies 7 Repository
baseurl=${NAGIOSXI_DEPS_BASEURL}
enabled=1
gpgcheck=1
gpgkey=${NAGIOS_GPGKEY_V2}
"

echo "${CENTOS_REPO_CONTENT}" | sudo tee ${CENTOS_REPO_FILE} > /dev/null
sudo rpm --import ${CENTOS_GPGKEY}
echo "${EPEL_REPO_CONTENT}" | sudo tee ${EPEL_REPO_FILE} > /dev/null
sudo rpm --import ${EPEL_GPGKEY}
echo "${NAGIOS_REPO_CONTENT}" | sudo tee ${NAGIOS_REPO_FILE} > /dev/null
sudo rpm --import ${NAGIOS_GPGKEY_V3}
echo "${NAGIOSXI_DEPS_REPO_CONTENT}" | sudo tee ${NAGIOSXI_DEPS_REPO_FILE} > /dev/null
sudo rpm --import ${NAGIOS_GPGKEY_V2}

sudo yum clean all
sudo yum makecache
sudo yum repolist

echo "Done!"
