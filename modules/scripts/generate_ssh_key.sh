#!/usr/bin/env bash
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

# Better SSH agent handling
echo "🔍 Checking SSH agent..."

# Function to start SSH agent
start_ssh_agent() {
  echo "🚀 Starting SSH agent..."
  eval "$(ssh-agent -s)"

  # Save agent info for future sessions
  echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK" > ~/.ssh/agent-info
  echo "export SSH_AGENT_PID=$SSH_AGENT_PID" >> ~/.ssh/agent-info
}

# Function to load existing agent
load_ssh_agent() {
  if [ -f ~/.ssh/agent-info ]; then
    source ~/.ssh/agent-info > /dev/null
  fi
}

# Try to load existing agent first
load_ssh_agent

# Check if agent is accessible
if ! ssh-add -l &>/dev/null; then
  echo "SSH agent not accessible, starting new one..."
  start_ssh_agent
else
  echo "✅ SSH agent is already running"
fi

# Add key to SSH agent
echo "➕ Adding key to SSH agent..."
if ssh-add ~/.ssh/id_ed25519; then
  echo "✅ Key successfully added to SSH agent"
else
  echo "⚠️  Could not add key to SSH agent automatically"
  echo "💡 You can add it manually later with: ssh-add ~/.ssh/id_ed25519"
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
echo "2. Add it to GitHub: https://github.com/settings/ssh"
echo "3. Add it to GitLab: https://gitlab.com/-/user_settings/ssh_keys"
echo "4. Test connections with: test-ssh-connections"
echo ""
echo "🔧 If SSH agent issues persist, run these commands:"
echo "   eval \"\$(ssh-agent -s)\""
echo "   ssh-add ~/.ssh/id_ed25519"
