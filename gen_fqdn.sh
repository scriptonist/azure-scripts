if [ $# -eq 0 ]
then
  printf "%s\n%s\n" "description: " "Usage: $0 <ip> <dns_name>"
  exit
fi

ip=$1
dnsname=$2


# Get the resource-id of the public ip
PUBLICIPID=$(az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$ip')].[id]" --output tsv)

# Update public ip address with DNS name
az network public-ip update --ids $ip --dns-name $dnsname

