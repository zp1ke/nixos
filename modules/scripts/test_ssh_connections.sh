#!/usr/bin/env bash

echo "🧪 Testing SSH connections..."

# Function to test SSH connection
test_ssh_connection() {
  local service=$1
  local host=$2
  local success_pattern=$3

  echo "Testing $service..."

  # Capture both stdout and stderr, ignore exit code
  local result=$(ssh -T git@$host -o ConnectTimeout=10 -o StrictHostKeyChecking=no 2>&1 || true)

  if echo "$result" | grep -q "$success_pattern"; then
    echo "✅ $service connection successful"
    echo "   $(echo "$result" | head -1)"
    return 0
  else
    echo "❌ $service connection failed"
    echo "   Output: $result"
    return 1
  fi
}

# Test GitHub
if ! test_ssh_connection "GitHub" "github.com" "successfully authenticated"; then
  exit 1
fi

echo ""

# Test GitLab
if ! test_ssh_connection "GitLab" "gitlab.com" "Welcome to GitLab"; then
  exit 1
fi

echo ""
echo "🎉 All SSH connections are working!"

# Show SSH key fingerprints
echo ""
echo "📋 Loaded SSH keys:"
ssh-add -l 2>/dev/null || echo "   No keys loaded in SSH agent"
