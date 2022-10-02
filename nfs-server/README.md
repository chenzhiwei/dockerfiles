# NFS Server

```
podman run -d --name nfs-server --cap-add SYS_ADMIN --cap-add SETPCAP -v /var/nfs:/var/nfs quay.io/siji/nfs-server
```
