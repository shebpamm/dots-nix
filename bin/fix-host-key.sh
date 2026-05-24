#!/usr/bin/env bash

set -euo pipefail

buffer=$(wezterm cli get-text)

host=$(echo "$buffer" | grep -oP '^Host key for \K[a-zA-Z0-9.-]+(?= has changed)' | tail -n 1)
offending_line=$(echo "$buffer" | grep -Po "Offending .* key in \K.*" | tail -n 1)

hosts_file=$(echo "$offending_line" | awk -F: '{print $1}')
line_number=$(echo "$offending_line" | awk -F: '{print $2}')

line_content=$(sed -n "${line_number}p" "$hosts_file")

if [[ $line_content != *"$host"* ]]; then
  echo "Hosts file mismatch: expected $host, but found $line_content"
  exit 1
fi

echo "Removed offending key from $hosts_file at line $line_number"

sed -i "${line_number}d" "$hosts_file"
