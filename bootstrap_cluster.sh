if [ $# -eq 0 ]
then
  printf "%s\n%s\n" "description" "Usage: $0 <cluster_name> <cluster_rg>"
  exit
fi

clname=$1
clrg=$2


echo "Creating cluster..."
./create_cluster.sh $clname $clrg

echo "Creating Static Ip"
./create_static_ip.sh $clname $clrg $clname

echo "Merging credentials Of Cluster with kubectl"
az aks get-credentials -n $clname -g $clrg

echo "Installing and configuring Helm"
kubectl apply -f https://gist.githubusercontent.com/scriptonist/5b357f524d4535afc789d6ccb1896616/raw/597af636be77da1f65e587ff843df46e9a76eadc/helm-rbac.yaml

helm init --service-account tiller

static_ip="$(./get_static_ip.sh $clname $clrg)"
echo "Installing Nginx Ingress controller, Waiting for tiller..."
sleep 20
helm install --name nginx-ing stable/nginx-ingress --set controller.service.loadBalancerIP=$static_ip


