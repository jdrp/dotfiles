from scapy.all import *
import statistics
import glob
import os

def process_pcap(pcap_file):
    sending_times = {}
    receiving_times = {}
    latencies = []
    
    packets = rdpcap(pcap_file)
    
    for packet in packets:
        if PPP in packet and IP in packet:
            print("a")
            ip_packet = packet[IP]
            if TCP in ip_packet:
                tcp_packet = ip_packet[TCP]
                seq_num = tcp_packet.seq
                ts = packet.time
                
                if tcp_packet.flags & 0x02:  # SYN flag
                    sending_times[seq_num] = ts
                elif seq_num in sending_times:
                    latency = ts - sending_times[seq_num]
                    receiving_times[seq_num] = ts
                    latencies.append(latency)
    
    if not latencies:
        print(f"No latency values found in {pcap_file}")
        return None, None, [], [], len(sending_times)
    
    avg_latency = statistics.mean(latencies)
    std_dev_latency = statistics.stdev(latencies)
    
    first_order_derivative = [latencies[i] - latencies[i-1] for i in range(1, len(latencies))]
    second_order_derivative = [first_order_derivative[i] - first_order_derivative[i-1] for i in range(1, len(first_order_derivative))]
    
    packet_loss = len(sending_times) - len(receiving_times)
    
    return avg_latency, std_dev_latency, first_order_derivative, second_order_derivative, packet_loss

# Usage
pcap_files = glob.glob('../traces/p2p*.pcap')

for pcap_file in pcap_files:
    print(f"Processing {pcap_file}")
    avg_latency, std_dev_latency, first_order_deriv, second_order_deriv, packet_loss = process_pcap(pcap_file)
    
    if avg_latency is not None:
        print(f"Average Latency: {avg_latency}")
        print(f"Standard Deviation of Latency: {std_dev_latency}")
        print(f"First-order Derivative of Latency: {first_order_deriv}")
        print(f"Second-order Derivative of Latency: {second_order_deriv}")
        print(f"Packet Loss: {packet_loss}")
        print("---")