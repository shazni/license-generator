#!/bin/bash

ls -alh
pwd
ls -alh ..

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:.

./LicenseGenerator --no-https