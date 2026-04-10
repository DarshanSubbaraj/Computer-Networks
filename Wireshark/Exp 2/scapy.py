from scapy.all import rdpcap
# Load the packet capture file
packets = rdpcap("C:\\Darshan\\CN\\Lab 3\\wireshark.pcapng")
# Total number of packets
print("Total number of packets:", len(packets))
# Initialize sets and dictionary
src_ips = set()
dst_ips = set()
protocol_count = {}

# Process each packet
for pkt in packets:
    if pkt.haslayer("IP"):
        src_ips.add(pkt["IP"].src)
        dst_ips.add(pkt["IP"].dst)
        proto = pkt["IP"].proto
        protocol_count[proto] = protocol_count.get(proto, 0) + 1
# Display results
print("Number of source IPs:", len(src_ips))
print("Number of destination IPs:", len(dst_ips))
print("Number of protocols used:", len(protocol_count))
print("Packets under each protocol:")
for proto, count in protocol_count.items():
    print(f"Protocol {proto}: {count} packets")
