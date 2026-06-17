#!/usr/bin/env bash

set -e

# Install via Anthropic's recommended method
# Script downloaded from them:
# https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases/bootstrap.sh

# Resolve the absolute path before su changes the working directory
BOOTSTRAP_SCRIPT="$(pwd)/bootstrap.sh"

# Run as the devcontainer user so that ~/.claude/, ~/.local/bin/claude, and
# ~/.local/share/claude/ are owned by the right user, not root.
su - "$_REMOTE_USER" <<EOF
bash "$BOOTSTRAP_SCRIPT" "$VERSION"
EOF

# Copy the binary to /usr/local/bin for global access
# It's installed in ~/.local/bin/claude and there's no option to override the install location
cp "$_REMOTE_USER_HOME/.local/bin/claude" /usr/local/bin/claude

echo 'Done!'
