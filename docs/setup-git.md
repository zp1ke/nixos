# Git and SSH Setup Guide

This guide covers setting up SSH keys and Git configuration after your NixOS installation is complete.

## Prerequisites

- Completed NixOS installation following [setup.md](setup.md)
- Logged into your system as user `zp1ke`
- Network connectivity

## Step 1: Generate SSH Keys

Your NixOS configuration includes convenient scripts for SSH key management.

1. **Generate SSH key:**
   ```bash
   generate-ssh-key
   ```

   This script will:
   - Generate an ED25519 SSH key at `~/.ssh/id_ed25519`
   - Set proper file permissions
   - Start SSH agent if needed
   - Add the key to SSH agent
   - Display your public key for copying

2. **Copy the public key displayed at the end of the script output**

## Step 2: Add SSH Keys to Git Services

### GitHub

1. **Go to GitHub SSH settings:**
   - Visit: https://github.com/settings/ssh/new
   - Or: GitHub → Settings → SSH and GPG keys → New SSH key

2. **Add your key:**
   - Title: `NixOS Legion` (or your preferred name)
   - Key: Paste the public key from step 1
   - Click "Add SSH key"

### GitLab

1. **Go to GitLab SSH settings:**
   - Visit: https://gitlab.com/-/user_settings/ssh_keys
   - Or: GitLab → Edit Profile → SSH Keys

2. **Add your key:**
   - Title: `NixOS Legion` (or your preferred name)
   - Key: Paste the public key from step 1
   - Click "Add key"

## Step 3: Test SSH Connections

1. **Test your SSH connections:**
   ```bash
   test-ssh-connections
   ```

   You should see:
   ```
   🧪 Testing SSH connections...
   Testing GitHub...
   ✅ GitHub connection successful
      Hi zp1ke! You've successfully authenticated, but GitHub does not provide shell access.

   Testing GitLab...
   ✅ GitLab connection successful
      Welcome to GitLab, @zp1ke!

   🎉 All SSH connections are working!
   ```

2. **Alternative: Test manually:**
   ```bash
   ssh -T git@github.com
   ssh -T git@gitlab.com
   ```

## Step 4: Verify Git Configuration

Your Git configuration is already set up through Home Manager, but let's verify it:

1. **Check Git configuration:**
   ```bash
   git config --list
   ```

   You should see:
   ```
   user.name=Matt Atcher
   user.email=zp1ke@proton.me
   core.editor=code --wait
   init.defaultbranch=main
   merge.conflictstyle=zdiff3
   pull.rebase=true
   push.default=simple
   ```

2. **Test Git SSH with alias:**
   ```bash
   git verify-ssh
   ```

## Step 5: Clone Your First Repository

Now you can clone repositories using SSH:

```bash
# Clone this configuration repository (if you want to manage it locally)
git clone git@github.com:zp1ke/nixos.git ~/nixos-config

# Clone any other repository
git clone git@github.com:username/repository.git
```

## Common Git Workflows

### Making Changes to Your NixOS Configuration

1. **Navigate to your config:**
   ```bash
   cd /etc/nixos
   ```

2. **Make changes and commit:**
   ```bash
   # Edit files as needed
   git add .
   git commit -m "Update configuration"
   git push
   ```

3. **Apply changes:**
   ```bash
   nixos-update  # Convenient alias
   ```

### Working with Other Repositories

```bash
# Clone a repository
git clone git@github.com:username/repo.git
cd repo

# Make changes
git add .
git commit -m "Your commit message"
git push
```

## Troubleshooting

### SSH Agent Issues

If SSH keys aren't loading automatically:

```bash
# Start SSH agent manually
eval "$(ssh-agent -s)"

# Add your key
ssh-add ~/.ssh/id_ed25519

# Verify keys are loaded
ssh-add -l
```

### Permission Denied (publickey)

1. **Verify your SSH key is added to the service (GitHub/GitLab)**
2. **Test SSH connection:**
   ```bash
   ssh -T git@github.com -v  # Verbose output for debugging
   ```
3. **Check SSH config:**
   ```bash
   cat ~/.ssh/config
   ```

### Git Configuration Issues

If Git settings seem incorrect:

```bash
# Check current config
git config --list

# Update if needed (though this should be managed by Home Manager)
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Regenerating SSH Keys

If you need to create new SSH keys:

```bash
# Remove old keys (optional)
rm ~/.ssh/id_ed25519*

# Generate new keys
generate-ssh-key

# Add new public key to GitHub/GitLab
# Test connections
test-ssh-connections
```

## Git Aliases Available

Your configuration includes useful Git aliases:

```bash
git verify-ssh    # Test SSH connections to GitHub and GitLab
```

## Security Best Practices

1. **Keep your private key secure** - Never share `~/.ssh/id_ed25519`
2. **Only share the public key** - The `.pub` file is safe to share
3. **Use different keys for different services** (optional but recommended for high security)
4. **Regularly rotate SSH keys** (every 6-12 months)
5. **Use SSH agent** to avoid entering passphrases repeatedly

## Next Steps

After completing this setup:

1. **Clone and contribute to repositories**
2. **Set up additional Git services** if needed
3. **Configure development environment** with your preferred tools
4. **Explore Home Manager** for additional customizations

## Getting Help

- **SSH Issues**: Check SSH verbose output with `-v` flag
- **Git Issues**: Use `git status` and `git log` for debugging
- **NixOS Discourse**: https://discourse.nixos.org/
- **Git Documentation**: https://git-scm.com/doc

---

**Note**: This setup uses a single SSH key for both GitHub and GitLab. For enhanced security in enterprise environments, consider using separate keys for different services.
