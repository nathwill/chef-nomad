# nomad

cookbook for installing/managing nomad

## Usage

Use the recipes

## Supports

client and server recipes only support 

 * Ubuntu 14.04

default recipe supports

 * debian-8.2
 * ubuntu-12.04
 * ubuntu-14.04
 * centos-6.7
 * centos-7.1


## Testing
Create the server with

```
kitchen converge server-ubuntu-1404
```

Create the client with

```
kitchen converge client-ubuntu-1404
```

The server and client are bridged on your local machine, with the IP addresses 192.168.17.243 and 192.168.17.242 respectively.  
