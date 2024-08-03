import socket

def port_scanner(target, ports):
    clcoding = socket.gethostbyname(target)
    print(f"Scanning {target} ({clcoding})")
    
    for port in ports:
        soc = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
        socket.setdefaulttimeout(1)
        result = soc.connect_ex((clcoding, port))
        
        if result == 0:
            print(f"Port {port} : Open")
        soc.close()
        
target = "ercanese.com"
ports = [80,443]

port_scanner(target,ports)