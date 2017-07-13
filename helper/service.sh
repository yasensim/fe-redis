#!/usr/bin/env bash

########################
# include the magic
########################
. ./demo-magic.sh

DEMO_PROMPT="[root@osmaster]# "

pe "oc get nodes"
pe "oc projects"
pe "oc new-project redis-isolated"
pe 'kubectl annotate ns redis-isolated "net.beta.kubernetes.io/network-policy={\"ingress\": {\"isolation\": \"DefaultDeny\"}}"'
pe "cat demo/redis.yml"
pe "oc create -f demo/redis.yml"
pe "oc get all -o wide"
pe "oc get all -o wide"

pe "oc new-project django-fe"
pe "oc adm policy add-scc-to-user anyuid -z default"
pe "cat demo/front-end.yml"
pe "oc create -f demo/front-end.yml"
pe "oc get all -o wide"
pe "oc get all -o wide"

pe "oc scale deploy/frontend --replicas=4"
pe "oc get all -o wide"
pe "oc expose service frontend"
pe "oc get all -o wide"

pe "oc project redis-isolated"
pe "cat demo/nwpolicy.yml"
pe "oc create -f demo/nwpolicy.yml"

