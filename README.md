# sysinfo
Here You can Download my system information script for linux

# Getting Started

to get started download the sysinfo.sh file 
proceed to make a folder in /var/lib and callit extra
paste the file into it and give it appropiate permissions, in my case i used chmod +x sysinfo.sh

now go in to your root folder and open .bashrc with root Perms 

make a new line at the end of the file and paste
```rb
sudo bash /var/lib/extra/sysinfo.sh
```
and save it, now when you run sudo su it should give you your system info
