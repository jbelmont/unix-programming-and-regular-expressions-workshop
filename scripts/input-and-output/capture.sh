#! /bin/bash

exec 2> myerr

node myfile.js

echo check myerr for errors