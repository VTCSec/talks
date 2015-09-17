
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

