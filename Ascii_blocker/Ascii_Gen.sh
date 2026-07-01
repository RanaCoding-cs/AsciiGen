#!/bin/bash

# কালার কোড
GREEN='\033[1;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
RED='\033[1;31m'
NC='\033[0m'

SAVE_FILE="Saved_Banners/all_banners.txt"

# মেইন ব্যানার
show_main_banner() {
    clear
    echo -e "${CYAN}"
    echo "    _    ____  ____ ___ ___    ____  _     ___   ____ _  __ _____ ____  "
    echo "   / \  / ___|/ ___|_ _| _ \  | __ )| |   / _ \ / ___| |/ /| ____|  _ \ "
    echo "  / _ \ \___ \\___ \| || | | | |  _ \| |  | | | | |   | ' / |  _| | |_) |"
    echo " / ___ \ ___) |___) | || |_| | | |_) | |__| |_| | |___| . \ | |___|  _ < "
    echo "/_/   \_\____/|____/___|___/  |____/|_____\___/ \____|_|\_\|_____|_| \_\ "
    echo -e "${WHITE}──────────────────────────────────────────────────────────────────────────"
    echo -e "${CYAN}      স্বাগতম ইমরান ভাই! তোমার নিজস্ব ব্যানার টুলস রেডি।               "
    echo -e "${WHITE}──────────────────────────────────────────────────────────────────────────${NC}\n"
}

# ব্যানার জেনারেট ফাংশন
generate_banner() {
    FONT_DIR="$PREFIX/share/figlet"
    
    if [ ! -d "$FONT_DIR" ]; then
        echo -e "${RED}এরর: ফন্ট ডিরেক্টরি পাওয়া যায়নি!${NC}"
        sleep 2
        return
    fi

    # ফন্ট লিস্ট তৈরি
    fonts=($(ls "$FONT_DIR" | sed 's/\.[^.]*$//' | sort -u))

    echo -e "${YELLOW}ইঞ্জিন সিলেক্ট করো:${NC}"
    echo "১) Figlet"
    echo "২) Toilet"
    read -p "অপশন (১ বা ২): " engine_choice

    echo -e "${YELLOW}ফন্ট নম্বর সিলেক্ট করো:${NC}"
    select font in "${fonts[@]}"; do
        if [ -n "$font" ]; then
            break
        else
            echo -e "${RED}ভুল ইনপুট! আবার সিলেক্ট করো।${NC}"
        fi
    done

    read -p "ব্যানারে কী লিখবে? " user_text

    # কমান্ড নির্ধারণ
    if [ "$engine_choice" == "2" ]; then
        echo -e "${YELLOW}স্টাইল সিলেক্ট করো:${NC}"
        echo "১) রঙিন (Gay) ২) মেটাল (Metal) ৩) সাধারণ"
        read -p "অপশন: " effect
        
        if [ "$effect" == "1" ]; then
            toilet -f "$font" --gay "$user_text" > .tmp_banner
        elif [ "$effect" == "2" ]; then
            toilet -f "$font" --metal "$user_text" > .tmp_banner
        else
            toilet -f "$font" "$user_text" > .tmp_banner
        fi
    else
        figlet -f "$font" "$user_text" > .tmp_banner
    fi

    # প্রিভিউ দেখানো
    echo -e "\n${CYAN}--- প্রিভিউ ---${NC}\n"
    cat .tmp_banner
    echo -e "\n${CYAN}----------------------------${NC}\n"

    # সেভ অপশন
    read -p "ব্যানারটি সেভ করবে? (y/n): " save_choice
    if [[ "$save_choice" == "y" || "$save_choice" == "Y" ]]; then
        mkdir -p Saved_Banners
        echo "--- $(date) ---" >> "$SAVE_FILE"
        cat .tmp_banner >> "$SAVE_FILE"
        echo -e "\n${GREEN}সেভ হয়েছে!${NC}"
    fi
    rm .tmp_banner
}

# প্রধান মেনু
while true; do
    show_main_banner
    echo -e "১) ব্যানার তৈরি করো"
    echo -e "২) সব ব্যানার দেখুন (cat)"
    echo -e "৩) এক্সিট"
    read -p "অপশন: " main_opt
    
    case $main_opt in
        1) generate_banner ;;
        2) 
            if [ -f "$SAVE_FILE" ]; then
                echo -e "\n${CYAN}--- সংরক্ষিত ব্যানারসমূহ ---${NC}\n"
                cat "$SAVE_FILE"
                read -p "ফিরে যেতে এন্টার টিপুন..."
            else
                echo -e "${RED}কোনো ফাইল নেই!${NC}"
                sleep 1
            fi
            ;;
        3) break ;;
        *) echo "ভুল অপশন!" ;;
    esac
done
