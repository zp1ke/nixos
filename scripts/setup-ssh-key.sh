set -e

SSH_DIR="$HOME/.ssh"
KEY_NAME="id_ed25519"
KEY_PATH="$SSH_DIR/$KEY_NAME"

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

if [ -f "$KEY_PATH" ]; then
  echo "SSH key already exists at $KEY_PATH"
  read -p "Do you want to overwrite it (y/N): " -n 1 -r
  echo
  if [[ ! $REPLY = ~^[Yy]$ ]]; then
    echo "Keeping existing key."
    exit 0
  fi
fi

read -p "Enter your email for the SSH key: " email

echo "Generating new ED25519 SSH key..."
ssh-keygen -t ed25519 -C "$email" -f "$KEY_PATH"

chmod 600 "$KEY_PATH"
chmod 644 "$KEY_PATH.pub"

if [ -z "$SSH_AUTO_SOCK" ]; then
  echo "SSH agent not running. Starting it now..."
  eval "$(ssh-agent -s)"
fi

echo "Adding key to SSH agent..."
if ssh-add "$KEY_PATH"; then
  echo "Key successfully added to SSH agent."
else
  echo "Could not add key to SSH agent automatically."
  echo "You can add it manually later with: ssh-add ~/.ssh/id_ed25519"
fi

echo -e "\nYour key to SSH agent:"
cat "$KEY_PATH.pub"

echo -e "\nSetup complete! You can now add this public key to your Github account."
if [ "$XDG_SESSION_DESKTOP" = "KDE" ] || [ "$XDG_CURRENT_DESKTOP" = "KDE" ]; then
  echo -r "\nFor Plasma integration, the SSH agent will be managed by KWallet after next login."
fi
