if [ $# -eq 0 ]
then 
  printf "%s\n%s\n" "usage:" "$0 <aks_cluster> <rg_group>"
  exit
fi

cluster=$1
rg=$2

# Get cluster rg name
aks_rg="$(az resource show --resource-group $rg --name $cluster --resource-type Microsoft.ContainerService/managedClusters --query properties.nodeResourceGroup -o tsv)"

# get the ip list in rg
az network public-ip list --resource-group $aks_rg --query [0].ipAddress --output tsv
