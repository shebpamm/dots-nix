#!/usr/bin/env -S nix shell nixpkgs#xorriso --command bash

set -euo pipefail

IMAGE="${1:-sops-secrets.iso}"
ENCRYPTED_KEY_PATH="$HOME/dotfiles/secrets/servers.key"
DEST_FILE_NAME="ssh_sops_server_key"

if [[ ! -f "$ENCRYPTED_KEY_PATH" ]]; then
    echo "Key file '$ENCRYPTED_KEY_PATH' does not exist."
    exit 1
fi

TMPDIR=$(mktemp -d)
cleanup() {
    rm -rf "$TMPDIR"
}
trap cleanup EXIT

echo "Decrypting key..."
sops -d "$ENCRYPTED_KEY_PATH" > "$TMPDIR/$DEST_FILE_NAME"
chmod 600 "$TMPDIR/$DEST_FILE_NAME"

echo "Creating ISO..."
xorriso -as mkisofs \
    -V sops-secrets \
    -o "$IMAGE" \
    "$TMPDIR"

echo
echo "Created: $IMAGE"
echo "Volume label: sops-secrets"
echo "Contains: /$DEST_FILE_NAME"
