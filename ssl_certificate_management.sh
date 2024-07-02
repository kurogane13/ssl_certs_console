#!/bin/bash

# Function to generate a private key
generate_private_key() {
    clear
    echo "----------------------------------"
    echo "Listing .key files:"
    echo 
    ls -lha *.key  # List all .key files in the current directory
    echo "--------------------------------------------------------------"
    echo "Private key file generation mode accessed:"
    echo
    read -p "Enter the name for the private key file (e.g., provided_server_key.key): " provided_server_key
    
    # Ensure the provided filename ends with .key
    if [[ ! "${provided_server_key}" =~ \.key$ ]]; then
        provided_server_key="${provided_server_key}.key"
    fi
    
    # Check if the key file already exists
    if [ -f "${provided_server_key}" ]; then
        echo "Private key file '${provided_server_key}' already exists."
        read -p "Press Enter to return to the main menu..."
        return
    fi
    
    openssl genrsa -out "${provided_server_key}" 2048  # Generate private key
    echo "Private key generated successfully: ${provided_server_key}"
    
    # Show the newly generated key file
    echo
    echo "Listing newly generated key file:"
    ls -lha "${provided_server_key}"
    echo
    
    read -p "Press Enter to return to the main menu..."
}

# Function to create a Certificate Signing Request (CSR)
create_csr() {
    clear
    echo "----------------------------------"
    echo "Listing .key files:"
    echo 
    ls -lha *.key  # List all .key files in the current directory
    echo "--------------------------------------------------------------"
    echo "Certificate Signing Request mode accessed:"
    echo
    read -p "Enter the name of the private key file (e.g., provided_server_key.key): " provided_server_key
    read -p "Enter the IP address for the CSR (e.g., 192.168.0.103): " provided_ip
    
    # Ensure the provided filename ends with .key
    if [[ ! "${provided_server_key}" =~ \.key$ ]]; then
        provided_server_key="${provided_server_key}.key"
    fi
    
    # Check if the key file exists
    if [ ! -f "${provided_server_key}" ]; then
        echo "Error: Private key file '${provided_server_key}' does not exist."
        read -p "Press Enter to return to the main menu..."
        return
    fi
    
    csr_file="${provided_server_key%.key}.csr"  # Replace .key with .csr for CSR file
    
    openssl req -new -key "${provided_server_key}" -out "${csr_file}" -subj "/C=AR/ST=BA/L=BuenosAires/O=GusOU=IT/CN=${provided_ip}"
    echo "CSR created successfully: ${csr_file}"
    
    read -p "Press Enter to return to the main menu..."
}

# Function to self-sign the CSR (create a self-signed certificate)
self_sign_csr() {
    clear
    echo "----------------------------------"
    echo "Listing .key files:"
    echo 
    ls -lha *.key  # List all .key files in the current directory
    echo "--------------------------------------------------------------"
    echo "Create a self-signed certificate mode accessed:"
    echo
    read -p "Enter the name of the private key file (e.g., provided_server_key.key): " provided_server_key
    
    # Ensure the provided filename ends with .key
    if [[ ! "${provided_server_key}" =~ \.key$ ]]; then
        provided_server_key="${provided_server_key}.key"
    fi
    
    # Check if the key file exists
    if [ ! -f "${provided_server_key}" ]; then
        echo "Error: Private key file '${provided_server_key}' does not exist."
        read -p "Press Enter to return to the main menu..."
        return
    fi
    
    crt_file="${provided_server_key%.key}.crt"  # Replace .key with .crt for CRT file
    
    openssl x509 -req -days 365 -in "${provided_server_key%.key}.csr" -signkey "${provided_server_key}" -out "${crt_file}"
    echo "Self-signed certificate created successfully: ${crt_file}"
    
    read -p "Press Enter to return to the main menu..."
}

# Function to convert the self-signed certificate to PEM format
convert_to_pem() {
    clear
    echo "----------------------------------"
    echo "Listing .key and .crt files:"
    echo 
    ls -lha *.key *.crt  # List all .key and .crt files in the current directory
    echo "--------------------------------------------------------------"
    
    read -p "Enter the name of the private key file (e.g., provided_server_key.key): " provided_server_key
    
    # Ensure the provided filename ends with .key
    if [[ ! "${provided_server_key}" =~ \.key$ ]]; then
        provided_server_key="${provided_server_key}.key"
    fi
    
    # Check if the key file exists
    if [ ! -f "${provided_server_key}" ]; then
        echo "Error: Private key file '${provided_server_key}' does not exist."
        read -p "Press Enter to return to the main menu..."
        return
    fi
    
    pem_file="${provided_server_key%.key}.pem"  # Replace .key with .pem for PEM file
    
    openssl x509 -in "${provided_server_key%.key}.crt" -out "${pem_file}" -outform PEM
    echo "Certificate converted to PEM format successfully: ${pem_file}"
    
    read -p "Press Enter to return to the main menu..."
}

# Function to verify the certificate
verify_certificate() {
    clear
    echo "----------------------------------"
    echo "Listing .crt files:"
    echo 
    ls -lha *.crt  # List all .crt files in the current directory
    echo "--------------------------------------------------------------"
    
    read -p "Enter the name of the .crt file to view: " crt_file
    if [ ! -f "${crt_file}" ]; then
        echo "Error: File '${crt_file}' does not exist."
        read -p "Press Enter to return to the main menu..."
        return
    fi
    
    openssl x509 -text -noout -in "${crt_file}"
    echo
    
    read -p "Press Enter to return to the main menu..."
}

# Function to test the OpenSSL connection
test_ssl_connection() {
    clear
    echo "----------------------------------"
    echo "Listing .key and .crt files:"
    echo 
    ls -lha *.key *.crt  # List all .key and .crt files in the current directory
    echo "--------------------------------------------------------------"
    
    read -p "Enter the name of the private key file (e.g., provided_server_key.key): " provided_server_key
    
    # Ensure the provided filename ends with .key
    if [[ ! "${provided_server_key}" =~ \.key$ ]]; then
        provided_server_key="${provided_server_key}.key"
    fi
    
    # Check if the key file exists
    if [ ! -f "${provided_server_key}" ]; then
        echo "Error: Private key file '${provided_server_key}' does not exist."
        read -p "Press Enter to return to the main menu..."
        return
    fi
    
    openssl s_server -key "${provided_server_key}" -cert "${provided_server_key%.key}.crt" -accept 443 -www &
    server_pid=$!
    echo
    echo "OpenSSL server started. You can test the connection from another terminal."
    echo "To stop the server, run: kill $server_pid"
    echo
    
    read -p "Press Enter to return to the main menu..."
}

# Function to verify the connection from another terminal
verify_connection() {
    clear
    echo "----------------------------------"
    echo "Listing .key and .crt files:"
    echo 
    ls -lha *.key *.crt  # List all .key and .crt files in the current directory
    echo "--------------------------------------------------------------"
    
    read -p "Enter the IP address to test SSL connection (e.g., 192.168.0.103): " provided_ip
    
    openssl s_client -connect "${provided_ip}:443"
    echo
    
    read -p "Press Enter to return to the main menu..."
}

# Function to show generated .pem files
show_pem_files() {
    clear
    echo "----------------------------------"
    echo "Listing generated .pem files:"
    echo 
    ls -lha *.pem  # List all .pem files in the current directory
    echo "--------------------------------------------------------------"
    
    read -p "Press Enter to return to the main menu..."
}

# Function to show .csr files
show_csr_files() {
    clear
    echo "----------------------------------"
    echo "Listing generated .csr files:"
    echo 
    ls -lha *.csr  # List all .csr files in the current directory
    echo "--------------------------------------------------------------"
    
    read -p "Press Enter to return to the main menu..."
}

# Function to show verified signed .csr files
show_verified_csr_files() {
    clear
    echo "----------------------------------"
    echo "Listing verified signed .csr files:"
    echo 
    ls -lha *.crt  # List all .crt files in the current directory
    echo "--------------------------------------------------------------"
    
    read -p "Press Enter to return to the main menu..."
}

# Function to view contents of specific file types
view_file_contents() {
    clear
    echo "----------------------------------"
    echo "View File Contents"
    echo
    echo "1. View .key files"
    echo "2. View .crt files"
    echo "3. View .csr files"
    echo "4. View .pem files"
    echo "5. Return to main menu"
    echo
    read -p "Please choose an option: " view_option

    case $view_option in
        1)
            clear
            echo "----------------------------------"
            echo "Listing .key files contents:"
            echo 
            ls -lha *.key  # List all .key files in the current directory
            echo "--------------------------------------------------------------"
            read -p "Enter the name of the .key file to view: " key_file
            if [ -f "${key_file}" ]; then
                cat "${key_file}"
            else
                echo "Error: File '${key_file}' does not exist."
            fi
            ;;
        2)
            clear
            echo "----------------------------------"
            echo "Listing .crt files contents:"
            echo 
            ls -lha *.crt  # List all .crt files in the current directory
            echo "--------------------------------------------------------------"
            read -p "Enter the name of the .crt file to view: " crt_file
            if [ -f "${crt_file}" ]; then
                openssl x509 -text -noout -in "${crt_file}"
            else
                echo "Error: File '${crt_file}' does not exist."
            fi
            ;;
        3)
            clear
            echo "----------------------------------"
            echo "Listing .csr files contents:"
            echo 
            ls -lha *.csr  # List all .csr files in the current directory
            echo "--------------------------------------------------------------"
            read -p "Enter the name of the .csr file to view: " csr_file
            if [ -f "${csr_file}" ]; then
                openssl req -text -noout -in "${csr_file}"
            else
                echo "Error: File '${csr_file}' does not exist."
            fi
            ;;
        4)
            clear
            echo "----------------------------------"
            echo "Listing .pem files contents:"
            echo 
            ls -lha *.pem  # List all .pem files in the current directory
            echo "--------------------------------------------------------------"
            read -p "Enter the name of the .pem file to view: " pem_file
            if [ -f "${pem_file}" ]; then
                cat "${pem_file}"
            else
                echo "Error: File '${pem_file}' does not exist."
            fi
            ;;
        5)
            return
            ;;
        *)
            echo "Invalid option, please try again."
            ;;
    esac

    echo
    read -p "Press Enter to return to the main menu..."
}

# Main menu loop
while true; do
    clear
    echo "----------------------------------"
    echo "SSL Certificate Management Menu"
    echo
    echo "1. Generate a Private Key"
    echo "2. Create a CSR (Certificate Signing Request)"
    echo "3. Self-sign the CSR (Certificate Signing Request)"
    echo "4. Convert Certificate to PEM"
    echo "5. Verify the Certificate"
    echo "6. Test SSL Connection (Server)"
    echo "7. Verify SSL Connection (Client)"
    echo "8. Show Generated .pem Files"
    echo "9. Show Generated .csr Files"
    echo "10. Show Verified Signed .csr Files"
    echo "11. View File Contents"
    echo "12. Exit"
    echo
    echo "----------------------------------"
    read -p "Please choose an option: " option

    case $option in
        1)
            generate_private_key
            ;;
        2)
            create_csr
            ;;
        3)
            self_sign_csr
            ;;
        4)
            convert_to_pem
            ;;
        5)
            verify_certificate
            ;;
        6)
            test_ssl_connection
            ;;
        7)
            verify_connection
            ;;
        8)
            show_pem_files
            ;;
        9)
            show_csr_files
            ;;
        10)
            show_verified_csr_files
            ;;
        11)
            view_file_contents
            ;;
        12)
            echo "Exiting the script. Goodbye!"
            break
            ;;
        *)
            echo "Invalid option, please try again."
            ;;
    esac
done
