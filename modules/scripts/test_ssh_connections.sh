#!/bin/bash

echo "🧪 Testing SSH connections..."

echo "Testing GitHub..."
if ssh -T git@github.com -o ConnectTimeout=10; then
  echo "✅ GitHub connection successful"
else
  echo "❌ GitHub connection failed"
  exit 1
fi

echo "Testing GitLab..."
if ssh -T git@gitlab.com -o ConnectTimeout=10; then
  echo "✅ GitLab connection successful"
else
  echo "❌ GitLab connection failed"
  exit 1
fi

echo "🎉 All SSH connections are working!"
