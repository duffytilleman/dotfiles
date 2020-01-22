#!/bin/bash
k-get-pod () {
  kubectl get pod -l app=$1 -o jsonpath="{.items[0].metadata.name}"
}

k-exec () {
  app=$1
  shift;
  pod=$(k-get-pod $app)
  kubectl exec -it $pod $@
}

k-logs () {
  app=$1
  shift
  kubectl logs $(k-get-pod $app) $@
}

k-delete-force () {
  app=$1
  kubectl delete --force --grace-period=0 pod $(k-get-pod $app)
}
