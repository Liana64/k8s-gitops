#!/usr/bin/bash

# Usage:  Encrypt all secrets and push
#         current changes to main branch,
#         then reconcile with flux.

if [ ! -d "$ROOT_DIR" ]; then
    echo "$ROOT_DIR does not exist. Make sure your env is loaded!"
    exit 1
fi

cd $ROOT_DIR

task sops:encrypt-all
git push -u origin main
task flux:reconcile
flux get all -A
