#!/bin/bash

cd /home/ubuntu/nuskusa-infra;
sudo git pull origin main;
docker compose build;
docker compose up -d;
