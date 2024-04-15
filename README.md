# Ubuntu Lab Host

[![Publish Docker image](https://github.com/networklessons/ubuntu-network-host/workflows/Publish%20Docker%20image/badge.svg?event=push)](https://github.com/networklessons/ubuntu-network-host/actions?query=workflow%3A"Publish+Docker+image")

![Docker Pulls](https://img.shields.io/docker/pulls/networklessons/ubuntu-lab-host)
![Docker Image Version](https://img.shields.io/docker/v/networklessons/ubuntu-lab-host)


[Ubuntu Lab Host on Docker Hub](https://hub.docker.com/r/networklessons/ubuntu-lab-host) 

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

