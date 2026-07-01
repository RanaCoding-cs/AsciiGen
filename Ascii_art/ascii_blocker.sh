#!/bin/bash

# কালার কোড
GREEN='\033[1;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
NC='\033[0m' 

# মেইন ব্যানার: এটি এখন অরিজিনাল এস্কি ব্লক আর্ট ডিজাইন
show_main_banner() {
    clear
    echo -e "${CYAN}"
    echo "    _    ____  ____ ___ ___    ____  _     ___   ____ _  __ _____ ____  "
    echo "   / \  / ___|/ ___|_ _| _ \  | __ )| |   / _ \ / ___| |/ /| ____|  _ \ "
    echo "  / _ \ \___ \\___ \| || | | | |  _ \| |  | | | | |   | ' / |  _| | |_) |"
    echo " / ___ \ ___) |___) | || |_| | | |_) | |__| |_| | |___| . \ | |___|  _ < "
    echo "/_/   \_\____/|____/___|___/  |____/|_____\___/ \____|_|\_\|_____|_| \_\ "
    echo -e "${WHITE}──────────────────────────────────────────────────────────────────────────"
    echo -e "${CYAN}      স্বাগতম ইমরান ভাই! তোমার নিজস্ব ব্যানার টুলস তৈরি হচ্ছে...         "
    echo -e "${WHITE}──────────────────────────────────────────────────────────────────────────${NC}\n"
}

# ফন্ট লোড করা
FONT_DIR="$PREFIX/share/figlet"
fonts=($(ls "$FONT_DIR" | sed 's/\.[^.]*$//' | sort -u))

# টুল স্টার্ট
show_main_banner

# ১. ফন্ট সিলেক্ট করা
echo -e "${YELLOW}[১] তুমি কোন ফন্টটি দিয়ে ব্যানার বানাতে চাও?${NC}"
select font in "${fonts[@]}"; do
    if [ -n "$font" ]; then
        echo -e "${GREEN}চমৎকার! তুমি '${font}' ফন্টটি বেছে নিয়েছ।${NC}\n"
        break
    else
        echo -e "${RED}দয়া করে লিস্ট থেকে একটি নম্বর সিলেক্ট করো।${NC}"
    fi
done

# ২. টেক্সট ইনপুট
read -p "ব্যানারে কী লিখতে চাও? (Text): " user_text

# ৩. স্টাইল সিলেকশন
echo -e "\n${YELLOW}[২] ব্যানারের স্টাইল বেছে নাও:${NC}"
echo -e "১) ${CYAN}রঙিন (Rainbow/Gay)${NC}"
echo -e "২) ${GREEN}মেটাল (Metal)${NC}"
echo -e "৩) ${WHITE}সাধারণ (Normal)${NC}"
read -p "অপশন নম্বর (১-৩): " style_choice

case $style_choice in
    1) cmd="toilet -f $font --gay \"$user_text\"" ;;
    2) cmd="toilet -f $font --metal \"$user_text\"" ;;
    *) cmd="figlet -f $font \"$user_text\"" ;;
esac

# ৪. প্রিভিউ
echo -e "\n${CYAN}--- তোমার ব্যানারের প্রিভিউ ---${NC}\n"
eval $cmd
echo -e "\n${CYAN}----------------------------${NC}\n"

# ৫. সেভ করা
read -p "ব্যানারটি কি সেভ করে রাখবে? (y/n): " save_choice

if [[ "$save_choice" == "y" || "$save_choice" == "Y" ]]; then
    mkdir -p Saved_Banners
    file_name="Saved_Banners/$(echo $user_text | tr ' ' '_')_$(date +%s).txt"
    
    echo "ব্যানার তৈরি: $(date)" > "$file_name"
    echo "ফন্ট: $font" >> "$file_name"
    echo "---------------------------" >> "$file_name"
    eval $cmd >> "$file_name"
    
    echo -e "\n${GREEN}সাবাশ! তোমার ব্যানারটি '${file_name}' নামে সেভ হয়েছে।${NC}"
else
    echo -e "${YELLOW}ঠিক আছে বন্ধু, আবার দেখা হবে!${NC}"
fi
