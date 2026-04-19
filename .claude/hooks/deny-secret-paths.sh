#!/usr/bin/env bash
# PreToolUse hook: block Bash commands that reference sensitive file patterns.
#
# Rationale: `permissions.deny` only covers the Read tool. Bash can still
# `cat`, `less`, `head`, `tail`, `xxd`, `strings`, `sops -d`, etc. This hook
# inspects the full resolved command string in one place.
#
# Stdin: JSON from Claude Code with tool_name and tool_input.command.
# Exit 0 = allow, exit 2 = block (stderr surfaces to the agent).

set -euo pipefail

input=$(cat)

tool=$(jq -r '.tool_name // ""' <<<"$input")
if [[ "$tool" != "Bash" ]]; then
    exit 0
fi

cmd=$(jq -r '.tool_input.command // ""' <<<"$input")

# Substring patterns. Broad on purpose: false positives cost a rename or
# cd, missed detections cost credentials.
pattern='\.tfvars|\.tfstate|kubeconfig|talosconfig|\.env\b|\.envrc|\bid_rsa\b|\bid_ed25519\b|\bid_ecdsa\b|\.agekey|\bage\.key\b|\.pem\b|\.p12\b|sops[[:space:]]+-d|sops[[:space:]]+--decrypt'

if echo "$cmd" | grep -qE "$pattern"; then
    matched=$(echo "$cmd" | grep -oE "$pattern" | head -1)
    {
        echo "Blocked by deny-secret-paths hook."
        echo "Matched pattern: ${matched}"
        echo "Command: ${cmd}"
    } >&2
    exit 2
fi

exit 0
