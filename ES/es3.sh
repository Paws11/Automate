#!/bin/bash
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update && sudo apt-get install elasticsearch
> /etc/elasticsearch/elasticsearch.yml
echo "################ES2#####################

cluster.name: my-cluster
node.name: node-3
path.data: /var/lib/elasticsearch
path.logs: /var/log/elasticsearch
network.host: 0.0.0.0
http.port: 9200
discovery.seed_hosts: ["10.0.0.66", "10.0.1.25", "10.0.2.234", "10.0.2.31", "10.0.2.208"]
cluster.initial_master_nodes: ["10.0.0.66"]

#######################################
" > /etc/elasticsearch/elasticsearch.yml
service elasticsearch start
iptables -A INPUT -p tcp -s localhost --dport 9200 -j ACCEPT
iptables -A INPUT -p tcp -s 172.31.0.0/16 --dport 9200 -j ACCEPT
iptables -A INPUT -p tcp -s 10.0.0.0/16 --dport 9200 -j ACCEPT
iptables -A INPUT -p tcp --dport 9200 -j DROP
