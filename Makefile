CC=gcc
CXX=g++
BIN_NAME=main

CFLAGS=-g -I mbedtls/include -I mbedtls/library -I mbedtls/3rdparty -I mbedtls/3rdparty/everest/include/everest/

MBEDTLS_SRC=mbedtls/library/aesni.c \
mbedtls/library/md4.c \
mbedtls/library/x509_crt.c \
mbedtls/library/x509_csr.c \
mbedtls/library/pkparse.c \
mbedtls/library/psa_crypto.c \
mbedtls/library/error.c \
mbedtls/library/entropy_poll.c \
mbedtls/library/ecjpake.c \
mbedtls/library/chachapoly.c \
mbedtls/library/havege.c \
mbedtls/library/rsa_internal.c \
mbedtls/library/certs.c \
mbedtls/library/psa_its_file.c \
mbedtls/library/threading.c \
mbedtls/library/x509write_csr.c \
mbedtls/library/sha256.c \
mbedtls/library/pk.c \
mbedtls/library/x509write_crt.c \
mbedtls/library/pkwrite.c \
mbedtls/library/pkcs12.c \
mbedtls/library/md.c \
mbedtls/library/des.c \
mbedtls/library/psa_crypto_se.c \
mbedtls/library/x509_crl.c \
mbedtls/library/asn1write.c \
mbedtls/library/x509_create.c \
mbedtls/library/ripemd160.c \
mbedtls/library/sha1.c \
mbedtls/library/x509.c \
mbedtls/library/memory_buffer_alloc.c \
mbedtls/library/md5.c \
mbedtls/library/pkcs5.c \
mbedtls/library/aria.c \
mbedtls/library/hmac_drbg.c \
mbedtls/library/cipher.c \
mbedtls/library/bignum.c \
mbedtls/library/cmac.c \
mbedtls/library/ecp_curves.c \
mbedtls/library/ccm.c \
mbedtls/library/base64.c \
mbedtls/library/hkdf.c \
mbedtls/library/oid.c \
mbedtls/library/version.c \
mbedtls/library/chacha20.c \
mbedtls/library/platform.c \
mbedtls/library/pem.c \
mbedtls/library/ecdh.c \
mbedtls/library/ecp.c \
mbedtls/library/xtea.c \
mbedtls/library/nist_kw.c \
mbedtls/library/aes.c \
mbedtls/library/arc4.c \
mbedtls/library/rsa.c \
mbedtls/library/pkcs11.c \
mbedtls/library/poly1305.c \
mbedtls/library/camellia.c \
mbedtls/library/pk_wrap.c \
mbedtls/library/ctr_drbg.c \
mbedtls/library/dhm.c \
mbedtls/library/platform_util.c \
mbedtls/library/gcm.c \
mbedtls/library/psa_crypto_driver_wrappers.c \
mbedtls/library/timing.c \
mbedtls/library/md2.c \
mbedtls/library/sha512.c \
mbedtls/library/psa_crypto_slot_management.c \
mbedtls/library/padlock.c \
mbedtls/library/version_features.c \
mbedtls/library/entropy.c \
mbedtls/library/blowfish.c \
mbedtls/library/asn1parse.c \
mbedtls/library/cipher_wrap.c \
mbedtls/library/ecdsa.c \
mbedtls/library/psa_crypto_storage.c

MBEDTLS_OBJ := $(sort $(MBEDTLS_SRC:.c=.o))

mbedtls/library/%.o: mbedtls/library/%.c
	$(CC) $(CFLAGS) -c $< -o $@

bin: $(MBEDTLS_OBJ)
	$(CXX) $^ main.cpp $(CFLAGS) -o $(BIN_NAME)

clean:
	rm -f $(MBEDTLS_OBJ) $(BIN_NAME)
