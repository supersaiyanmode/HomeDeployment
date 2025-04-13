export MAIN_HOST_NAME=eagle.com
export DHCP_ROUTER=192.168.86.1
export DHCP_START=192.168.86.50
export DHCP_END=192.168.86.250
export NEXTCLOUD_ADMIN_USER=srivatsan
export DNS_UPSTREAM=8.8.8.8,8.8.4.4

export CONFIGURE_BASIC="true"
export INSTALL_HTTP="true"
export INSTALL_MYSQL="true"
export INSTALL_PIHOLE="true"
export INSTALL_NEXTCLOUD="true"
export INSTALL_JELLYFIN="true"
export INSTALL_GITHUB_RUNNER="true"

if [[ "${INSTALL_PIHOLE}" == "true" && -z "${PI_HOLE_ADMIN_PASSWD}" ]]; then
  echo "Need PiHole password" 1>&2
  exit 1
fi

if [[ "${INSTALL_NEXTCLOUD}" == "true" && -z "${NEXTCLOUD_DB_PASSWD}" ]]; then
  echo "Need Database password" 1>&2
  exit 1
fi

if [[ "${INSTALL_NEXTCLOUD}" == "true" && -z "${NEXTCLOUD_ADMIN_PASSWD}" ]]; then
  echo "Need NextCloud Admin password" 1>&2
  exit 1
fi

if [[ "${INSTALL_GITHUB_RUNNER}" == "true" && -z "${GITHUB_TOKEN}" ]]; then
  echo "Need GitHub Runner token" 1>&2
  exit 1
fi

# Environment variables to set:
# TAILSCALE_AUTH_KEY
ansible-playbook -i $1, playbook.yml
