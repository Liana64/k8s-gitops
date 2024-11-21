#!/bin/bash

# Improved version of brettinternet's wip.sh
# https://github.com/brettinternet/homeops/blob/main/scripts/wip.sh
#
# Usage:
#  create WIP commit
#  push to current branch
#  reconcile the cluster with flux
#  remove previous WIP commit
#
# Options:
#  -c, --cluster <cluster_name>  Specify the cluster to reconcile (default: lianalabs)
#  -h, --help                   Show this help message
# Usage:  create WIP commit
#         push to current branch
#         reconcile the cluster with flux
#         remove previous WIP commit

CLUSTER="lianalabs"

function show_help {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  -c, --cluster <cluster_name>  Specify the cluster to reconcile (default: lianalabs)"
    echo "  -h, --help                   Show this help message"
    exit 0
}

# Ensure secrets can be encrypted before we push
function check_go_task {
    if ! command -v task &> /dev/null; then
        echo "Error: go-task is not installed. Please install it before running this script."
        exit 1
    fi
}
echo -n "Checking variables..."

if [ ! -d "$ROOT_DIR" ]; then
    echo ""
    echo "$ROOT_DIR does not exist. Make sure your env is loaded!"
    exit 1
fi

cd $ROOT_DIR

echo " Finished."

# Source: https://github.com/ohmyzsh/ohmyzsh/blob/1546e1226a7b739776bda43f264b221739ba0397/lib/git.zsh#L68-L81
function git_current_branch {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo "${ref#refs/heads/}"
}

function gwip {
  git add -A
  git rm $(git ls-files --deleted) 2> /dev/null
  git commit --no-gpg-sign -m "--wip-- [skipci]"
}

function gunwip {
  git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1
}

function gpcf {
  git push --force-with-lease origin "$(git_current_branch)"
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -c|--cluster)
            CLUSTER="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            ;;
        *)
            echo "Unknown parameter passed: $1"
            exit 1
            ;;
    esac
done

echo "Encrypting secrets"
echo ""
task sops:encrypt-all
echo ""
gwip
gpcf
echo "Reconciling flux"
echo ""
task flux:reconcile cluster=$CLUSTER
echo ""
echo "Git Log:"
gunwip
echo ""
echo "Waiting..."
echo ""
sleep 5
echo "Flux Status:"
flux get all -A
echo ""
