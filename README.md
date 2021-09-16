# email relay server docker image

## server config

/assets should be served as static files. example config for nginx proxy manager below after bind mounting /public in a static volume so npm can serve it. use /etc/fstab to mount at startup.

`mount --bind path/to/public/folder /path/to/nginx/static/files/email-relay`

```
location ~ ^/assets/ {
    root /static/email-relay;
}
```