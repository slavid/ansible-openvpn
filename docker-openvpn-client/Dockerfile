FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y openvpn iptables iptables-persistent

# COPY client.conf /etc/openvpn/client.conf
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
