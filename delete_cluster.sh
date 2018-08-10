if [ $# -eq 0 ]
then
  printf "%s\n%s\n" "deletes cluster and resource group" "Usage: $0 <cluster-name> <rg-name>"
  exit
fi
clustername=$1
rg=$2

echo "Deleting cluster $clustername"
az aks delete -y -n $clustername -g $rg --no-wait

az group delete -y -n $rg --no-wait
echo "Deleting RG $rg"
