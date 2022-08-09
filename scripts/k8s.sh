#!/bin/bash

export PATH=$PATH:$HOME/bin

export namespace=services

#alias k='kubectl -n $namespace'
alias k=kubectl

export selector=edge-combined
export deploy=$selector

k8s_ecr_auth() {
    # clean up old secret
    kubectl delete secret regcred
    export ecr_endpoint=477685780898.dkr.ecr.us-west-2.amazonaws.com
    export ecr_region=us-west-2
    local ns=${1:-netskrt}

    # authenticate to ecr + store as credentials file in $HOME/.docker/config.json
    aws ecr get-login-password --region $ecr_region | docker login --username AWS --password-stdin $ecr_endpoint

    # upload the secret to k8s
    kubectl create secret generic regcred \
      --from-file=.dockerconfigjson=$HOME/.docker/config.json \
      --namespace=$ns \
      --type=kubernetes.io/dockerconfigjson
 
}

k8s_sh() {
    local pod_name=${1:-$pod}
    k exec -it $pod_name -- bash
}

k8s_sync_misc() {
    # putting helper hooks into shared vol for now;  should later refactor into 
    CONTAINER=minikube 
    SRC_PATH=$(pwd)/scripts
    DEST_PATH=/tmp/hostpath-provisioner/default/edge-combined-pvc-misc

    # copy from container
    #docker exec $CONTAINER tar Ccf $(dirname $SRC_PATH) - $(basename $SRC_PATH) | tar Cxf DEST_PATH -

    #docker exec -it $CONTAINER rm $DEST_PATH/*

    # copy to container
    tar Ccf $(dirname $SRC_PATH) - $(basename $SRC_PATH) | docker exec -i $CONTAINER tar Cxf $DEST_PATH -

    docker exec -it $CONTAINER sh -c "mv $DEST_PATH/scripts/* $DEST_PATH/" 
    docker exec -it $CONTAINER sh -c "rm -rf $DEST_PATH/scripts"
    docker exec -it $CONTAINER sh -c "find $DEST_PATH -type f | xargs -I % sed -i 's/\r//g' %"

} 

k8s_watch_pods() {
    watch -n 3minikube kubectl get pods
}

k8s_watch_pod() {
    watch -n 3 sh -c 'kubectl describe pod $1 | tail'
}

k8s_up() {
    k8s_ecr_auth

    unzip misc.zip
    k apply -f misc/edge-combined-secrets-tls.yml
    rm -rf misc/
   
    k apply -f configmap-scripts.yml
    k apply -f volume-osdk.yml
    k apply -f ingress-osdk.yml
    k apply -f deploy-osdk.yml


}


k8s_backup() {
    local backup_dst=/share1/glyn/backup/osdk
    echo starting: $(date)
    set -x
    mkdir -p $backup_dst/{vault,netskrt,log,amazon-ca,cbc}

    # TODO: make more diff-y, less clobber-y
    k cp $pod:/var/cache/bscfg $backup_dst/vault
    k cp $pod:/data/netskrt $backup_dst/netskrt
    k cp $pod:/data/log $backup_dst/log
    k cp $pod:/cache/amazon-ca $backup_dst/amazon-ca
    k cp $pod:/cache/amazon-cbc $backup_dst/cbc
    set +x
    echo done: $(date)
}

k8s_job_run() {
    export job=aws-registry-credential-cron
    k apply -f $job.yml
    pod=$(k describe job $job | grep "Created pod:" | awk '{print$7}' | tail -n 1)
    echo waiting for pod/job creation...
    sleep 5
    while true; do
        k logs $pod | ts | tee out
        sleep 3
    done;
}

k8s_job_delete() {
    k delete job $job
}


################################################################################
# shortcuts 

function kwp {
    k8s_watch_pod $1
}

alias ksh=k8s_sh
alias kdp='kubectl describe pod'
kgp_() {
    kubectl get pods
    export pod=$(kubectl get pods | egrep "^edge-combined" | grep Running | awk '{print$1}' ) 
    echo "\nset active pod = $pod"
}
alias kgp=kgp_

alias krr="kubectl rollout restart deploy/$deploy"

# useful helper for formatting PEMs for putting into secrets
b64_() {
    base64 $1 | tr -d '\n' > $1.b64
}
alias b64=b64_

k8s_dump_secret() {
  k -n $namespace get secret $1 -o yaml \
    | yq e '.data."tls.crt"' - \
    | base64 -d \
    | openssl x509 -text -noout \
    | less
}

k8s_dump_secret_file() {
    cat $1 | yq e '.data."tls.crt"' - | base64 -d | openssl x509 -text -noout
}

k8s_ssl_dump_host() {
    openssl s_client -showcerts -servername $host -connect $host:443 | less
}

k8s_ssl_dump_crt() {
    #openssl x509 -inform pem -noout -text
    openssl x509 -in $cert_path -text -noout | less
}

alias krm="kubectl -n $namespace delete pod"
alias kgd="kubectl -n $namespace get deploy"
alias kdd="kubectl -n $namespace delete deploy"

alias ksc="kubectl config set-context --current --namespace=" 
kgy() { kubectl -o yaml get $@; }


