# docker-openvpn-template

### Build docker

```bash
docker-compose build
```

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

### Let client use Stubby (dns over TLS)

1. Edit `openvpn.conf`
```bash
nano /home/ubuntu/openvpndata/openvpn.conf
```
Add this line: `push "dhcp-option DNS 172.30.0.2"` as **first priority** than other `dhcp-option DNS`
Where the DNS ip is based on `docker-compose.yml` that you configured for stubby

2. Restart service
```bash
docker-compose up -d
# Check logs
docker-compose logs
```
