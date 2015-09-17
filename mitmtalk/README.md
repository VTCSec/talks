
On ubuntu I had to black list the WiFi card I was
using to mitm a network from Network Manager.  May not be applicable to you.

```bash
# add wifi card mac to /etc/NetworkManager/NetworkManager.conf
[keyfile]
unmanaged-devices=mac:11:22:33:44:55:66
```

Plug in wifi card and run:

```bash
# you may need to set the wlanX in the hostapd.conf file
sudo hostapd hostapd.conf
```

Run DHCPD

```bash
# you may need to set the wlanX in the udhcpd.conf file
sudo udhcpd udhcpd.conf
```

Forward traffic

```bash
# you may need to set variables in script...
sudo ./iptables.bash
```

now run mitmproxy!

```bash
# the -T is to run transparent proxy.  Dont use if u set your 
# black box to use a proxy.  --host will resolve IP to domain names.
mitmproxy -T --host
```

