# Samba Server

## Start

This samba server is anonymous read and write, please use with caution.

```
podman run -d --name samba -p 445:445 -v /var/samba:/samba-share docker.io/siji/samba:latest
```
