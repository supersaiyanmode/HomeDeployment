export MAIN_HOST_NAME=eagle.com
export DHCP_ROUTER=192.168.86.1
export DHCP_START=192.168.86.110
export DHCP_END=192.168.86.250
export NEXTCLOUD_ADMIN_USER=srivatsan

if [[ -z "${PI_HOLE_ADMIN_PASSWD}" ]]; then
  echo "Need PiHole password" 1>&2
  exit 1
fi

if [[ -z "${NEXTCLOUD_DB_PASSWD}" ]]; then
  echo "Need Database password" 1>&2
  exit 1
fi

if [[ -z "${NEXTCLOUD_ADMIN_PASSWD}" ]]; then
  echo "Need NextCloud Admin password" 1>&2
  exit 1
fi


# Environment variables to set:
# TAILSCALE_AUTH_KEY
ansible-playbook -i $1, playbook.yml
