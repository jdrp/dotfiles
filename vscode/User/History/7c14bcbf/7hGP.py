import dpkt
import socket
import statistics
import glob
import os

def process_pcap(pcap_file):
    sending_times = {}
    receiving_times = {}
    latencies = []
    
    with open(pcap_file, 'rb') as f:
        pcap = dpkt.pcap.Reader(f)
        
        for ts, buf in pcap:
            eth = dpkt.ethernet.Ethernet(buf)
            print(eth.type)
            
            if eth.type == dpkt.ethernet.ETH_TYPE_IP:
                ip = dpkt.ip.IP(eth.data)
                
                if ip.p == dpkt.ip.IP_PROTO_TCP:
                    tcp = ip.data
                    seq_num = tcp.seq
                    
                    if tcp.flags & dpkt.tcp.TH_SYN:
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