

help:   ## show this help
	@grep -E '^[a-z.A-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


clean-logs:   ## cleanup logs
	mv *.log log/ansible-k8s-deployment-log
	mv /home/netskrt/kubespray/*.log /home/netskrt/kubespray/log


sock:  ## setup ssh sock 	
	ls -t /tmp/ssh*

#INV :=  inventory/netskrt-infra/k8s_cluster_us_prod_sea.yml
#INV :=  inventory/netskrt-infra/k8s_single_node_test.yml
INV :=  inventory/netskrt-infra/k8s_cluster_netskrt_infra.yml
HOSTS := all
#TAGS := k8s-cert-manager
TAGS := k8s-external-dns

deploy:  ## deploy
	scripts/k8s-deploy.sh $(INV) $(HOSTS) $(TAGS)

test:  ## run tests
	scripts/k8s-deploy.sh $(INV) $(HOSTS) $(TAGS)-test

.PHONY: clean-logs help deploy test sock
