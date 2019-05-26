FROM kylemanna/openvpn:2.4 as build

RUN ovpn_genconfig -u udp://VPN.SERVERNAME.COM


FROM kylemanna/openvpn:2.4
MAINTAINER Nathan Lam

# USER root

# RUN mkdir /home/ovpndata
# RUN (ovpn_genconfig -u udp://VPN.SERVERNAME.COM && cp /etc/openvpn/*.sh /home/ovpndata/)
# RUN
COPY --from=build /etc/openvpn/*.sh /home/ubuntu/openvpndata/
# RUN rm -rf /home/ovpndata
# RUN ovpn_initpki




