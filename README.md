# SSL Certificate Management console

## Date: 07/02/2024

## Author: Gustavo Wydler Azuaga

## Introduction

SSL (Secure Sockets Layer) is a protocol used to establish a secure and encrypted connection between a client and a server over the internet. It ensures that the data transmitted between them remains private and integral.

Certificates are digital documents that verify the identity of the entities involved in an SSL connection (typically a server). They are issued by Certificate Authorities (CAs) and contain cryptographic keys that enable secure communication.

## Program Overview

This script facilitates SSL certificate management on a Linux system using OpenSSL. It allows users to:

- Generate private keys securely.
- Create Certificate Signing Requests (CSRs) to request a certificate from a CA.
- Self-sign CSRs to generate self-signed certificates for testing purposes.
- Convert certificates to PEM format for compatibility.
- Verify and view certificate details.
- Test SSL connections between servers and clients.

## Features and Functionalities

- **Private Key Generation:** Securely generates RSA private keys.
- **CSR Creation:** Creates CSRs with user-provided details and private keys.
- **Self-signing:** Generates self-signed certificates from CSRs.
- **PEM Conversion:** Converts certificates to PEM format.
- **Certificate Verification:** Displays certificate details for verification.
- **SSL Connection Testing:** Allows testing of SSL connections between server and client.

## Setup

1. **Requirements:**
   - OpenSSL installed on your Linux system.

2. **Usage:**
   - Clone the repository or download the script.
   - Make the script executable: `chmod +x ssl_certificate_management.sh`.
   - Run the script: `./ssl_certificate_management.sh`.
   - Follow on-screen prompts to perform desired SSL certificate management tasks.

3. **Additional Notes:**
   - Ensure you have appropriate permissions to write files in the current directory where the script is run.
   - For testing SSL connections, ensure ports are open and accessible between server and client.

## Example Workflow

1. Generate a private key (`generate_private_key`).
2. Create a CSR (`create_csr`) using the generated private key.
3. Self-sign the CSR (`self_sign_csr`) to obtain a self-signed certificate.
4. Convert the certificate to PEM format (`convert_to_pem`) if needed.
5. Verify certificate details (`verify_certificate`).
6. Test SSL connection (`test_ssl_connection`) between servers using OpenSSL.


