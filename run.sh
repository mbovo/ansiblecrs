#! /bin/bash

BASEDIR=$(dirname $0)
ANSIBLE_ROLES_PATH=${BASEDIR}/roles
PLAYBOOK=""

function setup(){
  set -e
  if [ -r ${BASEDIR}/venv/bin/activate ]; then
    echo "+ Found python virtualenv on ${BASEDIR}/venv"
    source ${BASEDIR}/venv/bin/activate
    echo -e "\t $(which python)"
    echo -e "\t $(which pip)"
  else
    echo "+ Creating python3 virtualenv"
    python3 -m venv ${BASEDIR}/venv
    echo "+ Enter virtualenv"
    source ${BASEDIR}/venv/bin/activate
    echo -e "\t $(which python)"
    echo -e "\t $(which pip)"
    pip install --upgrade pip
    echo "+ Install python libs"
    pip install -q -r requirements.txt
    #echo "+ Install ansible roles"
    #ansible-galaxy install -r requirements.yml
  fi
}


function usage(){
        echo
        echo "Usage $0 (-p playbook.yml) [-hf]"
        echo 
        echo -e "\t -p Playbook path"
        echo 
        exit 1
}

function main(){
  echo "+ run ansible-playbook"
  ansible-playbook -i inventory $PLAYBOOK

}

while getopts "fhp:" opt; do
  case ${opt} in
    p)
      PLAYBOOK=${OPTARG}
      ;;
    f)
      FAST=1
      ;;
    h)
      usage
      exit 0
      ;;
    \?)
      usage
      exit 1
      ;;
  esac
done

setup
main
deactivate