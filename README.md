# docker-openvpn-template


### Setup openvpn config

```bash
# 1. Generate openvpn config
docker-compose run --rm openvpn_server ovpn_genconfig -u udp://VPN.SERVERNAME.COM
# 2. Generate openvpn private key, cert... Please follow the step to enter the password
docker-compose run --rm openvpn_server ovpn_initpki
# 3. Create openvpn client user
docker-compose run --rm openvpn_server easyrsa build-client-full xxx nopass
# 4. Generate client .ovpn file
docker-compose run --rm openvpn_server ovpn_getclient xxx > xxx.ovpn
```

### Build docker

```bash
docker compose build
```

### Let client use Stubby (dns over TLS)

1. Start openvpn & Stubby
```bash
docker compose up -d
```

2. Check Stubby container's ip

```bash
# 1. check running container
docker ps -a
# 2. check Stubby container's ip
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' [Stubby container name/id]
```

3. Copy Stubby container's ip and modify openvpn config   
Let say openvpn config in `/home/ubuntu/openvpndata` (base on your mount volume location)
```bash
# 1.
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' [Stubby container name/id]
# 2.
nano /home/ubuntu/openvpndata/openvpn.conf
```
Add this line: `push "dhcp-option DNS [Stubby container's ip]"` as **first priority** than other `dhcp-option DNS`

4. Restart service
```bash
docker compose stop
docker compose up -d
```

