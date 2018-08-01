if [ $# -eq 0 ]
then
  printf "%s\n%s\n" "Create new static IP for the given cluster and resource group" "Usage: $0 <cluster_name> <rg_name> <ip_name>"
  exit
fi
clustername=$1
rgname=$2
ipname=$3

#AKS creates a new rg in a format MC_*
#Following command will get you this resource name
rgname_cluster="$(az resource show -g $rgname -n $clustername --resource-type Microsoft.ContainerService/managedClusters --query properties.nodeResourceGroup -o tsv)"

#Create static IP
echo "Creating a static ip with name $ipname"
az network public-ip create --resource-group $rgname_cluster --name $ipname --allocation-method static

echo "New Static IP created successfully."

az network public-ip list --resource-group $rgname_cluster --query [0].ipAddress --output tsv
