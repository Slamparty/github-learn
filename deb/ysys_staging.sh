#!/bin/bash

gnome-terminal --title 'ysys_k9s' --tab -- gcloud compute ssh --zone 'us-east1-b' 'jumphost' --project 'calcium-market-373517' --ssh-flag='-A';/
gnome-terminal --title 'ysys_staging' --tab -- gcloud compute ssh --zone 'us-east1-b' 'jumphost' --project 'calcium-market-373517' --ssh-flag='-A' -- k9s
