#!/bin/bash

# Create temp working directory
mkdir -p /mnt/vmw-tools

# Mount VMware Tools ISO
mount /dev/cdrom /mnt/vmw-tools

# Retrieve the VMware Tools package name from the directory
VMW_TOOLS=$(ls /mnt/vmw-tools/ | grep .gz)

# Copy VMware Tools package to /tmp
cp -f /mnt/vmw-tools/${VMW_TOOLS} /tmp/

# Unmount the VMware Tools ISO
umount /mnt/vmw-tools

# Clean up and remove temp mount directory
rmdir /mnt/vmw-tools

# Extract VMware Tools installer to /tmp
tar -zxvf /tmp/${VMW_TOOLS} -C /tmp/

# Change into VMware Tools installer directory
cd /tmp/vmware-tools-distrib/

# Create silent answer file for VMware Tools Installer

# If you wish to change which Kernel modules get installed. Mpte this script has been tested in RedHat 7.1
#
# 1.  In which directory do you want to install the binary files?  [/usr/bin]
# 2.  What is the directory that contains the init directories (rc0.d/ to rc6.d/)? [/etc/rc.d]
# 3.  What is the directory that contains the init scripts? [/etc/rc.d/init.d]
# 4.  In which directory do you want to install the daemon files? [/usr/sbin]
# 5.  In which directory do you want to install the library files? [/usr/lib/vmware-tools]
# 6.  The path "/usr/lib/vmware-tools" does not exist currently. This program is going to create it, including needed parent directories. Is this what you want? [yes]
# 7.  In which directory do you want to install the documentation files? [/usr/share/doc/vmware-tools]
# 8.  The path "/usr/share/doc/vmware-tools" does not exist currently. This program is going to create it, including needed parent directories. Is this what you want? [yes]
# 9.  Before running VMware Tools for the first time, you need to configure it by invoking the following command: "/usr/bin/vmware-config-tools.pl". Do you want this program to invoke the command for you now? [yes]
# 10. The VMware Host-Guesexit
# 12. VMware automatic kernel modules enables automatic building and installation of VMware kernel modules at boot that are not already present. This feature can be enabled/disabled by re-running vmware-config-tools.pl. Would you like to enable VMware automatic kernel modules?[no] yes <<====We want YES here
# 
#
cat > /tmp/answer << __ANSWER__
/usr/bin
/etc/rc.d
/etc/rc.d/init.d
/usr/sbin
/usr/lib/vmware-tools
yes
/usr/share/doc/vmware-tools
yes
yes
no
no
yes
__ANSWER__

# Install VMware Tools and redirecting the silent install file
./vmware-install.pl < /tmp/answer

# Final clean up
rm -rf vmware-tools-distrib/
rm -f /tmp/${VMW_TOOLS}
cd ~
