#! /bin/bash

name="Zach"

trap "echo name is $name" EXIT

name="Marcel"

sleep 2