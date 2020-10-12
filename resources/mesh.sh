#!/bin/bash


START_TS=$(date +%s)
SINV="${0} ${@}"
SDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


err() {
    echo; echo;
    echo -e "\e[97m\e[101m[ERROR]\e[0m ${1}"; shift; echo;
    while [[ $# -gt 0 ]]; do echo "    $1"; shift; done
    echo; exit 1;
}

# Checking if we are root
#test "$(whoami)" = "root" || err "Not running as root"

#export KUBEPASS='DhjTx-8gIJC-2h2tK-eksGY'

#oc login -u kubeadmin -p $KUBEPASS https://api.crc.testing:6443
#eval $(crc oc-env)
oc version
oc new-project istio-system

oc delete -f ./mesh-manifests/opgroup.yaml --ignore-not-found

oc delete -f ./mesh-manifests/subjaeger.yaml --ignore-not-found

oc delete -f ./mesh-manifests/subkiali.yaml --ignore-not-found

oc delete -f ./mesh-manifests/submesh.yaml --ignore-not-found


oc delete -f ./mesh-manifests/meshcontrolplane.yaml --ignore-not-found

oc delete -f ./mesh-manifests/meshmemberroll.yaml --ignore-not-found



oc apply -f ./mesh-manifests/opgroup.yaml

oc apply -f ./mesh-manifests/subjaeger.yaml

oc apply -f ./mesh-manifests/subkiali.yaml

oc apply -f ./mesh-manifests/submesh.yaml

echo "Waiting a bit..."
sleep 30

oc apply -f ./mesh-manifests/meshcontrolplane.yaml

oc apply -f ./mesh-manifests/meshmemberroll.yaml 


#https://access.redhat.com/documentation/en-us/openshift_container_platform/4.5/html/operators/olm-adding-operators-to-a-cluster
#https://docs.openshift.com/container-platform/4.5/service_mesh/service_mesh_install/installing-ossm.html#ossm-control-plane-deploy_installing-ossm

#OperatorGroup

#Subscription
