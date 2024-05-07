# NFS Server

## Start

```
# NFSv3 and NFSv4
podman run -d --name nfs-server --cap-add SYS_ADMIN -v /var/nfs:/var/nfs docker.io/siji/nfs-server

# NFSv3 only
podman run -d --name nfs-server -e NFSVER=3 --cap-add SYS_ADMIN -v /var/nfs:/var/nfs docker.io/siji/nfs-server

# NFSv4 only
podman run -d --name nfs-server -e NFSVER=4 --cap-add SYS_ADMIN -v /var/nfs:/var/nfs docker.io/siji/nfs-server

# NFSv3 and NFSv4
podman run -d --name nfs-server -e NFSVER=all --cap-add SYS_ADMIN -v /var/nfs:/var/nfs docker.io/siji/nfs-server
```

## Use

* NFSv3

    Use the absolute path:

    ```
    mount -o vers=3 server:/var/nfs /mnt
    ```

* NFSv4

    Use the relative path:

    ```
    mount -o vers=4 server:/ /mnt
    ```
