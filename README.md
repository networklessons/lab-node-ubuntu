# Lab Node Ubuntu

[![Publish Docker image](https://github.com/networklessons/lab-node-ubuntu/actions/workflows/build-push.yml/badge.svg)](https://github.com/networklessons/lab-node-ubuntu/actions/workflows/build-push.yml)
![Docker Pulls](https://img.shields.io/docker/pulls/networklessons/lab-node-ubuntu)
![Docker Image Version](https://img.shields.io/docker/v/networklessons/lab-node-ubuntu)
[![Docker](https://img.shields.io/docker/cloud/build/eaudeweb/scratch?label=Docker&style=flat)](https://hub.docker.com/r/networklessons/lab-node-ubuntu/tags)
<a href="https://twitter.com/networklessons" ><img src="https://img.shields.io/twitter/follow/networklessons.svg?style=social" /> </a>

[Lab Node Ubuntu on Docker Hub](https://hub.docker.com/r/networklessons/lab-node-ubuntu) 

WARNING: Don't use this container in production because it might contain default usernames, passwords, and/or keys. It is only intended for locally hosted labs.

Ubuntu base image with useful tools such as:

- vim
- nmap
- iperf3
- hping3
- curl

You can use this as a host, server, or node in emulators such as EVE-NG, Containerlab, etc.

https://github.com/networklessons/lab-node-ubuntu

## SSH

This container has a 'lab' user with password 'lab'. SSH is started on boot. This user can use `sudo`. If you don't want to execute everything with sudo, switch to the root user: `sudo su`.

## Change MAC address

You can change the MAC address so that it is easier to recognize things in debugs or Wireshark:

```
ip link set dev eth1 address 00:50:c2:53:40:01
```

## Change IP address

### Delete the Current IP Address (if needed)

First, if there's already an IP address assigned to `eth1` and you want to replace it, you can remove it using the `ip addr del` command. You need to know the current IP address assigned to do this. You can find it with `ip addr show eth1`. Then, replace `current.ip.address/xx` with the actual current IP configuration:
```
ip addr del current.ip.address/xx dev eth1
```

### Add the New IP Address

To add the new IP address `192.168.12.1/24` to the `eth1` interface, use:

```
ip addr add 192.168.12.1/24 dev eth1
```

### Enable the Interface

If the interface is not up, you need to enable it using the `ip link set` command:

```
ip link set eth1 up
```
## ARP / NDISC

### ARP Cache

You can see the arp cache like this:

```
root@s1:/home/ubuntu# ip neigh show dev eth1
172.16.12.2  FAILED
```

### Flush ARP & NDISC Cache

If you need to flush the IPv4 ARP or IPv6 NDISC cache, you can do this:

```
ip -s -s neighbor flush all
```

## Static Route

You could set the default gateway, but that might not be possible if you connect to this Docker container remotely. You can see the current routes here:

```
root@s1:/# ip route
default via 172.100.100.1 dev eth0 
172.100.100.0/24 dev eth0 proto kernel scope link src 172.100.100.16 
192.168.0.0/16 via 192.168.12.254 dev eth1
```

You can add a static route like this:

```
ip route add 192.168.0.0/16 via 192.168.12.254 dev eth1
```

It will show up like this:

```
root@s1:/# ip route
default via 172.100.100.1 dev eth0 
172.100.100.0/24 dev eth0 proto kernel scope link src 172.100.100.16 
192.168.0.0/16 via 192.168.12.254 dev eth1 
192.168.12.0/24 dev eth1 proto kernel scope link src 192.168.12.1
```
