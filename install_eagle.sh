export MAIN_HOST_NAME=home.base
export SUBNET="192.168.86.0/24"

export CONFIGURE_BASIC="true"
export CONFIGURE_GPIO="false"
export CONFIGURE_DOCKER="true"
export INSTALL_TRAEFIK="false"
export INSTALL_DOCKHAND="false"
export INSTALL_HAWSER="false"

export INSTALL_PIHOLE="false"
export INSTALL_NEXTCLOUD="false"
export INSTALL_JELLYFIN="false"
export INSTALL_GITHUB_RUNNER="false"
export INSTALL_WUD="false"
export INSTALL_TAILSCALE="false"
export INSTALL_QBITTORRENT="false"
export INSTALL_FORGEJO="false"
export INSTALL_SEMAPHORE="false"

if [ -f .env ]; then
  set -a
  source ./.env
  set +a
fi

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

if [[ "${INSTALL_TAILSCALE}" == "true" && -z "${TAILSCALE_AUTH_KEY}" ]]; then
  echo "Need TailScale Auth Key. See: https://login.tailscale.com/admin/settings/keys " 1>&2
  exit 1
fi

if [[ "${INSTALL_FORGEJO}" == "true" && -z "${FORGEJO_DB_PASSWD}" ]]; then
  echo "Need Database password" 1>&2
  exit 1
fi

if [[ "${INSTALL_SEMAPHORE}" == "true" && -z "${SEMAPHORE_DB_PASSWD}" ]]; then
  echo "Need Database password" 1>&2
  exit 1
fi

if [[ "${INSTALL_SEMAPHORE}" == "true" && -z "${SEMAPHORE_ADMIN_PASSWD}" ]]; then
  echo "Need Semaphore Admin password" 1>&2
  exit 1
fi

if [[ "${INSTALL_HAWSER}" == "true" && -z "${HAWSER_JOIN_TOKEN}" ]]; then
  echo "Need Hawser Join Token." 1>&2
  exit 1
fi

ansible-playbook -i hosts.yml playbook.yml
