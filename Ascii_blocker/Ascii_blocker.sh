#!/bin/bash

# কালার কোড
GREEN='\033[1;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
RED='\033[1;31m'
NC='\033[0m' 

SAVE_FILE="Saved_Banners/all_banners.txt"

# মেইন ব্যানার: হার্ডকোড করা ব্লক আর্ট
show_main_banner() {
    clear
    echo -e "${CYAN}"
    echo "    _    ____  ____ ___ ___    ____  _     ___   ____ _  __  "
    echo "   / \  / ___|/ ___|_ _| _ \  | __ )| |   / _ \ / ___| |/ / "
    echo "  / _ \ \___ \\___ \| || | | | |  _ \| |  | | | | |   | ' /  "
    echo " / ___ \ ___) |___) | || |_| | | |_) | |__| |_| | |___| . \  "
    echo "/_/   \_\____/|____/___|___/  |____/|_____\___/ \____|_|\_\| "
    echo -e "${WHITE}──────────────────────────────────────────────────────────────────────────"
    echo -e "${CYAN}      স্বাগতম ইমরান ভাই! তোমার নিজস্ব ব্যানার টুলস রেডি।               "
    echo -e "${WHITE}──────────────────────────────────────────────────────────────────────────${NC}\n"
}

# ব্যানার তৈরি ফাংশন
generate_banner() {
    FONT_DIR="$PREFIX/share/figlet"
    fonts=($(ls "$FONT_DIR" | sed 's/\.[^.]*$//' | sort -u))

    echo -e "${YELLOW}ইঞ্জিন সিলেক্ট করো:${NC}"
    echo "১) Figlet (সাধারণ ও নিখুঁত)"
    echo "২) Toilet (রঙিন ও ইফেক্টসহ)"
    read -p "অপশন (১/২): " engine_choice

    echo -e "\n${YELLOW}ফন্ট সিলেক্ট করো (লিস্ট থেকে নম্বর দাও):${NC}"
    select font in "${fonts[@]}"; do
        if [ -n "$font" ]; then
            break
        else
            echo -e "${RED}সঠিক নম্বরটি দাও।${NC}"
        fi
    done

    read -p "ব্যানারে কী লিখতে চাও? " user_text
    
    # ইঞ্জিন অনুযায়ী কমান্ড সেট করা
    if [ "$engine_choice" == "2" ]; then
        echo -e "\n১) রঙিন (Gay)\n২) মেটাল (Metal)\n৩) সাধারণ"
        read -p "ইফেক্ট নম্বর: " effect
        case $effect in
            1) cmd="toilet -f $font --gay \"$user_text\"" ;;
            2) cmd="toilet -f $font --metal \"$user_text\"" ;;
            *) cmd="toilet -f $font \"$user_text\"" ;;
        esac
    else
        cmd="figlet -f $font \"$user_text\""
    fi

    echo -e "\n${CYAN}--- প্রিভিউ ---${NC}\n"
    eval $cmd
    
    read -p "এটি সেভ করবেন? (y/n): " save_choice
    if [[ "$save_choice" == "y" || "$save_choice" == "Y" ]]; then
        mkdir -p Saved_Banners
        echo "--- $(date) ---" >> "$SAVE_FILE"
        echo "ইঞ্জিন: $([ "$engine_choice" == "2" ] && echo "Toilet" || echo "Figlet") | ফন্ট: $font" >> "$SAVE_FILE"
        eval $cmd >> "$SAVE_FILE"
        echo -e "\n${GREEN}সেভ হয়েছে!${NC}"
    fi
}

# মেইন মেনু
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
                echo -e "${RED}কোনো ব্যানার সেভ করা নেই।${NC}"
                sleep 1
            fi
            ;;
        3) exit 0 ;;
        *) echo "ভুল অপশন!" ;;
    done
done
