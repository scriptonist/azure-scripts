if [ $# -eq 0 ]
then
  printf "%s\n%s\n%s" "create a new aks cluster with the given particulars" "Usage:" "$0 <cluster_name> <rg_name>"
  exit
fi

echo "Creating cluster $1 in $2"

az aks create -n $1 -g $2 --enable-rbac --node-count 1 --kubernetes-version 1.10.5 --generate-ssh-keys
