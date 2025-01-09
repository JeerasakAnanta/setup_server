#!/bin/bash

# Function to check for outdated packages
check_outdated_packages() {
    echo "Checking for outdated packages..."
    sudo apt update > /dev/null
    UPDATES=$(apt list --upgradable 2> /dev/null | wc -l)
    if [ "$UPDATES" -gt 1 ]; then
        echo "There are $((UPDATES - 1)) outdated packages. Please update them."
    else
        echo "No outdated packages found."
    fi
}

# Function to install Lynis if not present and run an audit
run_lynis() {
    if ! command -v lynis &> /dev/null; then
        echo "Installing Lynis..."
        sudo apt install -y lynis
    fi

    echo "Running Lynis audit..."
    sudo lynis audit system
}

# Function to check for firewall status
check_firewall_status() {
    echo "Checking if UFW is enabled..."
    if sudo ufw status | grep -q "inactive"; then
        echo "UFW is inactive. It is recommended to enable it."
    else
        echo "UFW is active."
    fi
}

# Function to check for any exposed services
check_exposed_services() {
    echo "Checking for exposed services..."
    sudo apt install -y net-tools
    if ss -tuln | grep -q LISTEN; then
        echo "The following services are listening on the network:"
        ss -tuln | grep LISTEN
    else
        echo "No services are currently listening on the network."
    fi
}

# Main function
main() {
    echo "Starting vulnerability check..."
    check_outdated_packages
    run_lynis
    check_firewall_status
    check_exposed_services
    echo "Vulnerability check completed."
}

# Execute the main function
main

exit 0