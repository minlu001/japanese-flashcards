#!/bin/bash

sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --reload
