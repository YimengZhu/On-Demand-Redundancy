# EdgeMonitor

## standalone usage
`bash setup.sh`\
`python3 monitor.py`

## containerize
* build docker image:\
`docker build -t yimengzhu/edgemonitor:v1 .`

* start the docker:\
`docker run --network host -it -v /dev/bus/usb:/dev/bus/usb edgemonitor:v1`

## building cluster
- On **master**

    - install and start k3s:\
`curl -sfL https://get.k3s.io | sh -`

    - check systemd status:\
`sudo systemctl status k3s`

    - get the join key:\
`sudo cat /var/lib/rancher/k3s/server/node-token`\
it will return something like:
`K1065b25cbb674d57d2c1317a1dbb20f6c351e710a0f3c40f6ca52431384103f5c4::server:4ff2057e09a1d0b0eff3be0ee5e07b2c`

- On **node**

    - export environmental variable about server:\
`export K3S_URL="https://serverip"`\
`export K3S_TOKEN="K1065b25cbb674d57d2c1317a1dbb20f6c351e710a0f3c40f6ca52431384103f5c4::server:4ff2057e09a1d0b0eff3be0ee5e07b2c"`

    - run the install script:
`curl -sfL https://get.k3s.io | sh -`

    - join the cluster manually:
`sudo k3s agent --server ${K3S_URL} --token ${K3S_TOKEN}`


## running cluster

* create namespace:\
`kubectl create -f edgemonitor.yaml`

    check namespace:\
`kubectl get namespaces`

* create service:\
`kubectl create -f service.yaml`

    check service:\
`kubectl get services -n edgemonitor`

* create deployment:\
`kubectl create -f deployment.yaml`

    check deployment:\
`kubectl get deployment edgemonitor -n edgemonitor`

## deleting resource
`kubectl delete -f {edgemonitor, service, deployment}.yaml`
