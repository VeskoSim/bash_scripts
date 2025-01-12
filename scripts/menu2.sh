#!/bin/bash

# Bash script that checks:
# - Memory usage
# - CPU load
# - Number of TCP connections
# - Kernel version

# Define server name
server_name=$(hostname)

# Color variables
green='\033[0;32m'
blue='\033[0;34m'
red='\033[0;31m'
clear='\033[0m'

# Functions for checks
function memory_check() {
    echo -e "\nThe current memory usage on ${server_name} is:"
    if command -v free &> /dev/null; then
        free -h
    else
        echo "Using alternative method for memory usage:"
        systeminfo | findstr /C:"Available Physical Memory"
    fi
    echo ""
}


function cpu_check() {
    echo -e "\nCPU load on ${server_name} is:"
    if command -v uptime &> /dev/null; then
        uptime
    else
        echo "Using alternative method for CPU load:"
        wmic cpu get loadpercentage
    fi
    echo ""
}

function tcp_check() {
    echo -e "\nTCP connections on ${server_name} are:"
    if command -v netstat &> /dev/null; then
        netstat -an | findstr "ESTABLISHED" | wc -l
    else
        echo "Command 'netstat' not found. Please install it or use a compatible environment."
    fi
    echo ""
}



function kernel_check() {
    echo -e "\nKernel version on ${server_name} is:"
    uname -r
    echo ""
}

function all_check() {
    memory_check
    tcp_check
    kernel_check
    cpu_check
}

# Color functions
Color_green() {
    echo -ne "${green}$1${clear}"
}

Color_blue() {
    echo -ne "${blue}$1${clear}"
}

# Menu function
menu() {
    echo -ne "
My first menu
$(Color_green '1)') Memory usage
$(Color_green '2)') CPU
$(Color_green '3)') Number of TCP connections
$(Color_green '4)') Kernel version
$(Color_green '5)') Run all checks
$(Color_blue '0)') Exit
$(Color_blue 'Choose an option: ') "

    read a
    case $a in
        1) memory_check ; menu ;;
        2) cpu_check ; menu ;;
        3) tcp_check ; menu ;;
        4) kernel_check ; menu ;;
        5) all_check ; menu ;;
        0) exit 0 ;;
        *) echo -e "${red}Wrong option.${clear}" ; menu ;;
    esac
}

# Call the menu function
menu
