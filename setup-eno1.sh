#!/bin/bash

nmcli connection add type ethernet ifname eno1 con-name eno1-dhcp
nmcli connection up eno1-dhcp

