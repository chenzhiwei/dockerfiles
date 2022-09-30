# Container Registry

```
podman run -d --ip 10.88.1.1 -p 443:443 -v /var/lib/registry:/var/lib/registry --name container-registry quay.io/siji/registry:2
```
