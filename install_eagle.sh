export MAIN_HOST_NAME=home.base
export SUBNET="192.168.86.0/24"

if [ -f .env ]; then
  set -a
  source ./.env
  set +a
fi

ANSIBLE_DISPLAY_SKIPPED_HOSTS=false ansible-playbook -i hosts.yml playbook.yml "$@"
