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

Create the three clients with

```
kitchen converge client-1-ubuntu-1404
kitchen converge client-2-ubuntu-1404
kitchen converge client-3-ubuntu-1404

```

The server and client are bridged on your local machine.  The server has the IP address 192.168.17.243.  The clients have the IP addresses 192.168.17.240-242 respectively.  

Log in to the server via:

```
kitchen login server-ubuntu-1404
```

And view the status with the commands

```
nomad node-status
nomad server-members
```
