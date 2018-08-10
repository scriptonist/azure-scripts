if [ $# -eq 0 ]
then
  printf "%s\n%s\n" "deploy new gitlab helm chart" "Usage: $0 <domain> <ip>  <email>"
  exit
fi

domain=$1
ip=$2
email=$3

helm repo add gitlab https://charts.gitlab.io/
helm update
helm upgrade --install gitlab gitlab/gitlab \
  --timeout 600 \
  --set global.hosts.domain=$domain \
  --set global.hosts.externalIP=$ip \
  --set certmanager-issuer.email=$email

