import dpkt
import socket
import statistics

def process_pcap(pcap_file):
    sending_times = {}
    receiving_times = {}
    latencies = []
    
    with open(pcap_file, 'rb') as f:
        pcap = dpkt.pcap.Reader(f)
        
        for ts, buf in pcap:
            print(ts)
            print(buf)
            eth = dpkt.ethernet.Ethernet(buf)
            
            if isinstance(eth.data, dpkt.ip.IP):
                ip = eth.data
                
                if isinstance(ip.data, dpkt.tcp.TCP):
                    tcp = ip.data
                    seq_num = tcp.seq
                    
                    if tcp.flags & dpkt.tcp.TH_SYN:
                        sending_times[seq_num] = ts
                    elif seq_num in sending_times:
                        latency = ts - sending_times[seq_num]
                        receiving_times[seq_num] = ts
                        latencies.append(latency)
    
    avg_latency = statistics.mean(latencies)
    std_dev_latency = statistics.stdev(latencies)
    
    first_order_derivative = []
    for i in range(1, len(latencies)):
        derivative = latencies[i] - latencies[i-1]
        first_order_derivative.append(derivative)
    
    second_order_derivative = []
    for i in range(1, len(first_order_derivative)):
        derivative = first_order_derivative[i] - first_order_derivative[i-1]
        second_order_derivative.append(derivative)
    
    packet_loss = len(sending_times) - len(receiving_times)
    
    return avg_latency, std_dev_latency, first_order_derivative, second_order_derivative, packet_loss

# Usage
pcap_file = '../traces/p2p-6-0.pcap'
avg_latency, std_dev_latency, first_order_deriv, second_order_deriv, packet_loss = process_pcap(pcap_file)
print(f"Average Latency: {avg_latency}")
print(f"Standard Deviation of Latency: {std_dev_latency}")
print(f"First-order Derivative of Latency: {first_order_deriv}")
print(f"Second-order Derivative of Latency: {second_order_deriv}")
print(f"Packet Loss: {packet_loss}")