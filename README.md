# MBEDTLS X509 certificate parsing
## What is it
If ever tried to find x509 DER or PEM parsing and verification facilities to embed in your low-level C/C++ code and failed you are in right place. This project contains MBEDTLS' certificates parsing/validation subsystem ready to embed in any C project.

## How to build and embed
Build requires no additional dependencies. Just run `make` command:
```
$ make
```
The project's Makefile is easy to modify, you may add your own custom CFLAGs or easily embed in your project build system.
You may want to change some of building parameters in `./mbedtls/include/mbedtls/config.h`.
