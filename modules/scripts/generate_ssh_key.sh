set -e  # Exit on any error

echo "🔐 Generating SSH key for Git repositories..."

# Check if SSH is available
if ! command -v ssh &> /dev/null; then
  echo "❌ ERROR: SSH is not installed or not in PATH"
  exit 1
fi

# Check if ssh-keygen is available
if ! command -v ssh-keygen &> /dev/null; then
  echo "❌ ERROR: ssh-keygen is not available"
  exit 1
fi

# Create .ssh directory if it doesn't exist
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Check if key already exists
if [ -f ~/.ssh/id_ed25519 ]; then
  echo "⚠️  SSH key already exists at ~/.ssh/id_ed25519"
  read -p "Do you want to overwrite it? (y/N): " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "🛑 Aborted by user"
    exit 0
  fi
fi

# Generate SSH key
echo "🔑 Generating ED25519 SSH key..."
if ! ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -C "zp1ke@proton.me" -N ""; then
  echo "❌ ERROR: Failed to generate SSH key"
  exit 1
fi

# Set proper permissions
echo "🔒 Setting proper permissions..."
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub

# Check if SSH agent is running
if ! pgrep -x ssh-agent > /dev/null; then
  echo "🚀 Starting SSH agent..."
  eval "$(ssh-agent -s)"
  if [ $? -ne 0 ]; then
    echo "❌ ERROR: Failed to start SSH agent"
    exit 1
  fi
fi

# Add key to SSH agent
echo "➕ Adding key to SSH agent..."
if ! ssh-add ~/.ssh/id_ed25519; then
  echo "❌ ERROR: Failed to add key to SSH agent"
  exit 1
fi

echo ""
echo "🎉 SSH key generation completed!"
echo "📋 Your public key (copy this to GitHub/GitLab):"
echo "----------------------------------------"
cat ~/.ssh/id_ed25519.pub
echo "----------------------------------------"
echo ""
echo "📝 Next steps:"
echo "1. Copy the public key above"
echo "2. Add it to GitHub: https://github.com/settings/ssh/new"
echo "3. Add it to GitLab: https://gitlab.com/-/profile/keys"
echo "4. Test connections again with: ~/.ssh/test_connections.sh"
