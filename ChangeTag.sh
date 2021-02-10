#!/bin/bash
sed "s/tagVersion/$1/g" KubernetesDeployFlou.yaml > kubernetes-deploy-app.yaml