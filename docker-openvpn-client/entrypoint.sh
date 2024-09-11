#!/bin/bash

# Habilitar el reenvío de IPv4
echo 1 > /proc/sys/net/ipv4/ip_forward

# Reglas IPtables:

# Habilitar NAT en la interfaz tun0 (de OpenVPN)
iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE

# Permitir el tráfico que va desde la red interna (eth0) a través del túnel (tun0)
iptables -A FORWARD -i eth0 -o tun0 -j ACCEPT

# Permitir el tráfico que regresa desde el túnel (tun0) hacia la red interna (eth0)
iptables -A FORWARD -i tun0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT

# Permitir tráfico loopback (interfaz lo)
iptables -A INPUT -i lo -j ACCEPT

# Permitir a los dispositivos de la red local hacer ping al host (Raspberry Pi)
iptables -A INPUT -i eth0 -p icmp -j ACCEPT

# Permitir conexiones SSH desde la red interna
iptables -A INPUT -i eth0 -p tcp --dport 22 -j ACCEPT

# Permitir todo el tráfico iniciado por el host (máquina contenedora) para que pueda regresar
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

# Establecer la política predeterminada para las cadenas INPUT y FORWARD a DROP
iptables -P INPUT DROP
iptables -P FORWARD DROP

# Iniciar OpenVPN
openvpn --config /etc/openvpn/client.conf
