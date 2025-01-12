#!/bin/bash

# Bash script that check
# -Memory usage
# -CPU load
# -Number of TCP connections
# -Krenel versions

function memory_check() {
    echo ""
        echo "The current memory usage on ${server_name} is: "
        free -h
        echo ""
}

function cpu_check() {
    echo ""
        echo "CPU load on ${server_name} is: "
    echo ""
        uptime
    echo ""
}

function tcp_check() {
    echo ""
        echo "TCP connections on ${server_name} is: "
    echo ""
        cat /proc/net/tcp | wc -l
    echo ""
}

function kernel_check() {
    echo ""
        echo "Kernel version on ${server_name} is: "
        echo ""
        uname -r
    echo ""    
}

function all_check() {
memory_check
tcp_check
kernel_check
cpu_check
}

all_check