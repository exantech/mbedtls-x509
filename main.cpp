#include <iostream>
#include <fstream>
#include <vector>
#include <map>

#include "mbedtls/x509_crt.h"

static const std::map<int, const char*> errors = {
    {-0x006E, "This is a bug in the library"},
    {-0x2080, "Unavailable feature, e.g. RSA hashing/encryption combination."},
    {-0x2100, "Requested OID is unknown."},
    {-0x2180, "The CRT/CRL/CSR format is invalid, e.g. different type expected."},
    {-0x2200, "The CRT/CRL/CSR version element is invalid."},
    {-0x2280, "The serial tag or value is invalid."},
    {-0x2300, "The algorithm tag or value is invalid."},
    {-0x2380, "The name tag or value is invalid."},
    {-0x2400, "The date tag or value is invalid."},
    {-0x2480, "The signature tag or value invalid."},
    {-0x2500, "The extension tag or value is invalid."},
    {-0x2580, "CRT/CRL/CSR has an unsupported version number."},
    {-0x2600, "Signature algorithm (oid) is unsupported."},
    {-0x2680, "Signature algorithms do not match. (see mbedtls_x509_crt sig_oid)"},
    {-0x2700, "Certificate verification failed, e.g. CRL, CA or signature check failed."},
    {-0x2780, "Format not recognized as DER or PEM."},
    {-0x2800, "Input invalid."},
    {-0x2880, "Allocation of memory failed."},
    {-0x2900, "Read/write of file failed."},
    {-0x2980, "Destination buffer is too small."},
    {-0x3000, "A fatal error occurred, eg the chain is too long or the vrfy callback failed."},
    {-0x3F80, "Memory allocation failed."},
    {-0x3F00, "Type mismatch, eg attempt to encrypt with an ECDSA key"},
    {-0x3E80, "Bad input parameters to function."},
    {-0x3E00, "Read/write of file failed."},
    {-0x3D80, "Unsupported key version"},
    {-0x3D00, "Invalid key tag or value."},
    {-0x3C80, "Key algorithm is unsupported (only RSA and EC are supported)."},
    {-0x3C00, "Private key password can't be empty."},
    {-0x3B80, "Given private key password does not allow for correct decryption."},
    {-0x3B00, "The pubkey tag or value is invalid (only RSA and EC are supported)."},
    {-0x3A80, "The algorithm tag or value is invalid."},
    {-0x3A00, "Elliptic curve is unsupported (only NIST curves are supported)."},
    {-0x3980, "Unavailable feature, e.g. RSA disabled for RSA key."},
    {-0x3900, "The buffer contains a valid signature followed by more data."}
};

int main() {
    std::ifstream file("cert.der", std::ios::binary | std::ios::ate);
    if (!file.is_open()) {
        std::cerr << "failed to open der-file" << std::endl;
        return 1;
    }

    std::streamsize size = file.tellg();
    file.seekg(0, std::ios::beg);

    std::vector<uint8_t> buf(size);
    if (!file.read(reinterpret_cast<char*>(buf.data()), size))
    {
        std::cerr << "something went wrong\n";
        return 2;
    }

    std::cout << size << " bytes were read" << std::endl;

    mbedtls_x509_crt crt;
    mbedtls_x509_crt_init(&crt);

    int res = mbedtls_x509_crt_parse_der(&crt, buf.data(), buf.size());
    if (res < 0) {
        std::string reason;
        auto it = errors.find(res);
        if (it != errors.end()) {
            reason = it->second;
        } else {
            reason = "reason not found";
        }

        std::cerr << "failed to parse der-file: " << reason << "\n";
    } else {
        std::cout << "certificate is parsed successfully" << std::endl;
    }

    mbedtls_x509_crt_free(&crt);

    return 0;
}