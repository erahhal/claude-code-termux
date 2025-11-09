# 📱 Complete Setup Guide: Claude Code on Android/Termux

This guide walks you through **A-Z** installation of Claude Code on an Android device. Estimated time: **30-45 minutes** (depending on download speeds).

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Install Termux](#install-termux)
3. [Initial Termux Setup](#initial-termux-setup)
4. [Install Runtimes (Node.js, Python, Rust)](#install-runtimes)
5. [Install Claude Code](#install-claude-code)
6. [Configure API Keys](#configure-api-keys)
7. [Verify Installation](#verify-installation)
8. [Troubleshooting](#troubleshooting)

---

## Prerequisites

**Hardware Requirements:**
- Android device (Version 7.0+, recommended 10+)
- Minimum 4GB RAM (8GB+ recommended for smooth operation)
- 5GB free storage space
- USB-C or micro-USB port (for faster data transfers, optional)
- Stable WiFi connection (for initial setup and package downloads)

**What You'll Need:**
- F-Droid app store account (free, open-source alternative to Google Play)
- GitHub account (for pushing code)
- Anthropic API key (for Claude access)
  - Get it at: https://console.anthropic.com/
  - Or use other providers: Grok, DeepSeek, OpenAI

**Knowledge Assumptions:**
- Comfort with terminal/command-line
- Basic understanding of Linux commands
- Understanding of environment variables and `.bashrc`/`.zshrc`

---

## Install Termux

### Step 1: Download Termux

**IMPORTANT**: Use **F-Droid**, NOT Google Play Store
- Google Play version has restricted capabilities
- F-Droid version has full Linux environment access

**Method A: Via F-Droid App Store (Recommended)**
1. Install F-Droid: https://f-droid.org/
2. Open F-Droid app
3. Search for "Termux"
4. Install latest version (should be 0.118.0 or newer)
5. Launch Termux

**Method B: Manual Download**
1. Visit: https://github.com/termux/termux-app/releases
2. Download latest `*.apk` file (e.g., `termux-v0.118.0.apk`)
3. Enable "Unknown Sources" in Android settings
4. Tap the APK to install
5. Launch Termux

### Step 2: Grant Storage Permission

Termux needs access to your device storage:

```bash
termux-setup-storage
```

This will prompt you to allow storage access. **Tap "Allow"**.

Verify it worked:
```bash
ls ~/storage
```

You should see: `downloads`, `documents`, `pictures`, `dcim`, `movies`, etc.

---

## Initial Termux Setup

### Step 1: Update Package Manager

```bash
pkg update && pkg upgrade -y
```

This downloads and upgrades the Termux package repository. Takes 2-5 minutes depending on connection.

### Step 2: Install Essential Tools

```bash
pkg install -y \
  git \
  curl \
  wget \
  openssh \
  nano \
  vim \
  htop \
  build-essential \
  pkg-config
```

This gives you basic development tools.

### Step 3: Configure Your Shell (Optional but Recommended)

**Use Bash (default):**
```bash
# Bash is already default, verify:
echo $SHELL
# Should output: /data/data/com.termux/files/usr/bin/bash
```

**Or install Zsh (more powerful):**
```bash
pkg install -y zsh
chsh -s zsh
# Exit and restart Termux
exit
```

Verify:
```bash
echo $SHELL
# Should output: /data/data/com.termux/files/usr/bin/zsh
```

### Step 4: Set Up Home Directory

```bash
# Create important directories
mkdir -p ~/.local/bin
mkdir -p ~/.config
mkdir -p ~/projects

# Verify
ls -la ~
```

---

## Install Runtimes

You'll need three runtimes to work with most projects.

### Install Node.js

```bash
pkg install -y nodejs

# Verify
node --version    # Should be 18+, 20+, or 22+
npm --version     # Package manager for Node
npx --version     # Node package executor
```

Expected output: `v24.9.0` or similar (latest stable)

### Install Python

```bash
pkg install -y python

# Verify
python --version   # Should be 3.8+
python3 --version  # Explicit Python 3
pip --version      # Package manager
pip3 --version     # Explicit pip3
```

Expected output: `Python 3.12.12` or newer

### Install Rust (Optional but Recommended)

Rust is needed if you want to use `fractal-mcp-rust` or build Rust projects.

```bash
pkg install -y rust

# This may take 5-10 minutes for first installation

# Verify
rustc --version    # Rust compiler
cargo --version    # Rust package manager
```

Expected output: `rustc 1.90.0` or similar

---

## Install Claude Code

Claude Code is Anthropic's CLI tool. Installation method depends on what's available:

### Method 1: Via NPM (Recommended)

```bash
npm install -g @anthropic-ai/claude-code
```

This installs Claude Code globally (available system-wide).

Verify:
```bash
which claude-code
claude-code --version
```

### Method 2: Via Cargo (If from Anthropic Rust Package)

```bash
# Check if available
cargo search claude-code

# If found:
cargo install claude-code
```

### Method 3: Build from Source

```bash
# Clone the repository
git clone https://github.com/anthropics/claude-code.git
cd claude-code

# Install dependencies
npm install

# Install globally
npm install -g .

# Verify
claude-code --version
```

---

## Configure API Keys

Claude Code needs an API key to communicate with Claude.

### Option A: Use Anthropic API Key (Recommended)

1. Get API key at: https://console.anthropic.com/
2. Copy your API key (starts with `sk-ant-`)

Create environment variable:

```bash
# Using your editor
nano ~/.bashrc  # or ~/.zshrc if using Zsh

# Add this line at the end:
export ANTHROPIC_API_KEY="sk-ant-..."

# Save and exit (Ctrl+X, then Y, then Enter)

# Reload your shell
source ~/.bashrc  # or source ~/.zshrc
```

Verify:
```bash
echo $ANTHROPIC_API_KEY
# Should print your API key (first 7 chars visible is normal)
```

### Option B: Use Other Providers (Grok, DeepSeek, OpenAI)

If using alternative providers, set:

```bash
# OpenAI
export OPENAI_API_KEY="sk-..."

# DeepSeek
export DEEPSEEK_API_KEY="sk-..."

# Grok
export GROK_API_KEY="xai-..."
```

Add to `~/.bashrc` or `~/.zshrc` just like above.

### Option C: Interactive Configuration

```bash
claude-code init
# Follow prompts to configure
```

---

## Verify Installation

Run the included verification script:

```bash
bash scripts/verify.sh
```

Or manually verify each component:

```bash
# Check Termux environment
uname -a          # Should show Linux, ARM64
echo $HOME        # Should be /data/data/com.termux/files/home
echo $PATH        # Should include /home/term/.local/bin

# Check runtimes
node --version    # ≥ 18.0.0
python --version  # ≥ 3.8.0
rustc --version   # ≥ 1.70.0 (optional)

# Check Claude Code
which claude-code
claude-code --version

# Test API connection
claude-code --help
# Should work without errors
```

### First Test Run

```bash
# Simple test
echo "Hello from Termux!" | claude-code "explain this in 1 sentence"

# File operations test
echo "test content" > /tmp/test.txt
claude-code "summarize this file: /tmp/test.txt"

# System command test
claude-code "what's in my current directory?" ls

# Code analysis test (if in a git repo)
cd ~/projects/some-project
claude-code "explain the main architecture of this codebase"
```

---

## Next Steps

### 1. Set Up Git (Version Control)

```bash
# Configure git identity
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Generate SSH key (optional, for GitHub access)
ssh-keygen -t ed25519 -C "your.email@example.com"
# Just press Enter for all prompts to use defaults

# Display public key (copy this to GitHub)
cat ~/.ssh/id_ed25519.pub
```

### 2. Create a Projects Directory

```bash
mkdir -p ~/projects
cd ~/projects

# Create your first project
mkdir my-first-project
cd my-first-project
git init
echo "# My First Project" > README.md
git add .
git commit -m "Initial commit"
```

### 3. Test with Your Projects

```bash
cd ~/projects/my-first-project

# Ask Claude Code to create a file
claude-code "create a simple hello world script in node.js"

# Ask Claude Code to modify code
echo "console.log('test')" > test.js
claude-code "refactor this code to be more readable"

# Use Claude Code for git workflows
claude-code "push my latest changes to GitHub"
```

---

## Troubleshooting

### "Command not found: claude-code"

**Cause**: Claude Code not in PATH

**Solution**:
```bash
# Check installation
npm list -g | grep claude-code

# If not found, reinstall
npm install -g @anthropic-ai/claude-code

# Add to PATH (if needed)
echo 'export PATH=$PATH:~/.npm-global/bin' >> ~/.bashrc
source ~/.bashrc
```

### "Permission denied" errors

**Cause**: File permissions issues

**Solution**:
```bash
# Fix permissions in home directory
chmod -R 755 ~

# For specific files
chmod 600 ~/.bashrc
chmod 600 ~/.ssh/id_ed25519
```

### "API key not found" or authentication errors

**Cause**: API key not configured

**Solution**:
```bash
# Verify key is set
echo $ANTHROPIC_API_KEY
# Should show your key (or part of it)

# If empty, configure it:
nano ~/.bashrc
# Add: export ANTHROPIC_API_KEY="your-key-here"
# Save and reload: source ~/.bashrc

# Test connection
claude-code --version
```

### "No space left on device"

**Cause**: Storage is full

**Solution**:
```bash
# Check disk usage
df -h

# Clean package cache
pkg clean

# Remove old files
rm -rf ~/storage/downloads/old-downloads/*
```

### "Slow performance" or "device freezing"

**Cause**: Device running out of memory

**Solution**:
```bash
# Check memory usage
free -h

# Close unused apps on Android

# Reduce background processes
# In Termux: Close other terminal tabs

# Consider: Restart device for full memory refresh
```

### Timeout or network errors

**Cause**: Poor internet connection

**Solution**:
```bash
# Verify connection
curl https://api.anthropic.com
# Should show some response (not connection error)

# Test with retry
curl --retry 3 https://api.anthropic.com

# Use faster WiFi if possible
```

### Custom features not working

**Known Issue**: Custom slash commands don't work on Termux

**Workaround**:
- Use standard Claude Code commands
- See [KNOWN_ISSUES.md](./KNOWN_ISSUES.md) for full list

---

## Advanced Configuration (Optional)

### Use Custom Shell Startup

Create a custom `.bashrc` configuration:

```bash
cat >> ~/.bashrc << 'EOF'

# Claude Code on Android - Custom Configuration

# Aliases for common commands
alias cl="claude-code"
alias cls="claude-code stats"
alias clh="claude-code history"

# Custom function: Quick project setup
function new-project() {
  mkdir -p ~/projects/$1
  cd ~/projects/$1
  git init
  echo "# $1" > README.md
  git add .
  git commit -m "Initial commit"
  echo "✅ Project '$1' created in ~/projects/$1"
}

# Display useful info on startup
echo "🚀 Welcome to Claude Code on Termux!"
echo "   Node: $(node --version)"
echo "   Python: $(python --version)"
echo "   Rust: $(rustc --version 2>/dev/null || echo 'Not installed')"
echo ""
echo "📝 Quick commands:"
echo "   cl 'task'        - Run Claude Code"
echo "   new-project name - Create a new project"
echo ""

EOF

source ~/.bashrc
```

### Enable SSH Access (Optional)

Access Termux from your computer:

```bash
# Install and start SSH server
pkg install openssh
sshd

# Display connection info
ssh-keygen -lf ~/.ssh/id_rsa.pub
# Use the displayed info to connect from computer
```

### Mount External Storage (Advanced)

```bash
# View mounted storage
mount | grep storage

# Symlink important directories
ln -s ~/storage/documents ~/docs
ln -s ~/storage/downloads ~/downloads
```

---

## Maintenance

### Keep Everything Updated

```bash
# Update Termux packages monthly
pkg update && pkg upgrade -y

# Update NPM packages
npm update -g

# Update Rust
rustup update

# Update Claude Code
npm update -g @anthropic-ai/claude-code
```

### Backup Your Configuration

```bash
# Backup .bashrc and important configs
cp ~/.bashrc ~/storage/documents/bashrc.backup
cp ~/.gitconfig ~/storage/documents/gitconfig.backup

# Backup SSH keys (KEEP PRIVATE!)
cp -r ~/.ssh ~/storage/documents/ssh.backup
chmod 600 ~/storage/documents/ssh.backup/*
```

---

## Support

- **Stuck?** Check [KNOWN_ISSUES.md](./KNOWN_ISSUES.md)
- **Found a bug?** Open an issue in this repository
- **Want to help?** See [CONTRIBUTING.md](./CONTRIBUTING.md)

**Happy coding on your phone!** 📱✨
