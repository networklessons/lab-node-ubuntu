# Ubuntu Network Host

[![Publish Docker image](https://github.com/networklessons/ubuntu-network-host/workflows/Publish%20Docker%20image/badge.svg?event=push)](https://github.com/networklessons/ubuntu-network-host/actions?query=workflow%3A"Publish+Docker+image")

WARNING: Don't use this container in production because it might contain default usernames, passwords, and/or keys. It is only intended for locally hosted labs.

Ubuntu base image with useful tools such as:

- vim
- nmap
- iperf3
- hping3
- curl

You can use this in emulators such as EVE-NG, Containerlab, etc.

https://github.com/networklessons/ubuntu-network-host

## Change IP address on container

### Delete the Current IP Address (if needed)

First, if there's already an IP address assigned to `eth1` and you want to replace it, you can remove it using the `ip addr del` command. You need to know the current IP address assigned to do this. You can find it with `ip addr show eth1`. Then, replace `current.ip.address/xx` with the actual current IP configuration:
```
sudo ip addr del current.ip.address/xx dev eth1
```

### Add the New IP Address

To add the new IP address `192.168.12.1/24` to the `eth1` interface, use:

```
sudo ip addr add 192.168.12.1/24 dev eth1
```

### Enable the Interface

If the interface is not up, you need to enable it using the `ip link set` command:

```
sudo ip link set eth1 up
```