from scapy.all import *

packets = rdpcap("C:\\Darshan\\College\\CN Lab\\check_sum.pcapng")

for pkt in packets:
    if IP in pkt:
        ip = pkt[IP]
        old_ip_chksum = ip.chksum
        del ip.chksum
        new_ip_chksum = IP(bytes(ip)).chksum
        
        print("IP Checksum:")
        print("Stored:", old_ip_chksum, "Calculated:", new_ip_chksum)

    if TCP in pkt:
        tcp = pkt[TCP]
        old_tcp_chksum = tcp.chksum
        del tcp.chksum
        new_tcp_chksum = TCP(bytes(tcp)).chksum
        
        print("TCP Checksum:")
        print("Stored:", old_tcp_chksum, "Calculated:", new_tcp_chksum)

    if UDP in pkt:
        udp = pkt[UDP]
        old_udp_chksum = udp.chksum
        del udp.chksum
        new_udp_chksum = UDP(bytes(udp)).chksum
        
        print("UDP Checksum:")
        print("Stored:", old_udp_chksum, "Calculated:", new_udp_chksum)

    if ICMP in pkt:
        icmp = pkt[ICMP]
        old_icmp_chksum = icmp.chksum
        del icmp.chksum
        new_icmp_chksum = ICMP(bytes(icmp)).chksum
        
        print("ICMP Checksum:")
        print("Stored:", old_icmp_chksum, "Calculated:", new_icmp_chksum)

    print("-" * 40)
