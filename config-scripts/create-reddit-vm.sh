#!/bin/bash
gcloud compute instances create reddit-app-full \ 
--project=infra-207413 \ 
--zone=europe-west1-b \ 
--machine-type=g1-small \ 
--subnet=default \ 
--no-restart-on-failure \ 
--tags=puma-server \ 
--image-family=reddit-full \ 
--image-project=infra-207413 \ 
--boot-disk-size=10GB \ 
--boot-disk-type=pd-standard \ 
--boot-disk-device-name=reddit-app-full
