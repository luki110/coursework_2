#!/bin/bash
minikube start --vm-driver=virtualbox

kubectl create deployment coursework2 --image=szarlej110/coursework2:latest

kubectl expose deployment/coursework2 --port=8080 --type="NodePort" --name node-port-service

kubectl scale deployments/coursework2 --replicas=4



