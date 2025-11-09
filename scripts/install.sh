#!/bin/bash

# Claude Code on Android/Termux - Installation Script
# Purpose: Automated setup of Claude Code environment
# Usage: bash scripts/install.sh

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Claude Code on Android/Termux - Installation Script          ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check if running in Termux
if [ ! -d "/data/data/com.termux" ]; then
  echo -e "${YELLOW}⚠️  Warning: Not running in Termux environment${NC}"
  echo "This script is designed for Termux on Android."
  echo "Some steps may not work correctly."
  echo ""
fi

# Function to log steps
log_step() {
  echo -e "${BLUE}➜${NC} $1"
}

log_success() {
  echo -e "${GREEN}✓${NC} $1"
}

log_error() {
  echo -e "${RED}✗${NC} $1"
}

# ============================================================================
# Step 1: Update Package Manager
# ============================================================================

log_step "Updating package manager..."
echo "This may take a few minutes..."
if pkg update -y > /dev/null 2>&1; then
  log_success "Package manager updated"
else
  log_error "Failed to update packages"
  echo "Try running manually: pkg update -y"
fi

# ============================================================================
# Step 2: Install Essential Tools
# ============================================================================

log_step "Installing essential tools..."
PACKAGES="git curl wget nano vim build-essential"

for pkg in $PACKAGES; do
  echo -ne "  Installing $pkg... "
  if pkg install -y "$pkg" > /dev/null 2>&1; then
    echo -e "${GREEN}✓${NC}"
  else
    echo -e "${YELLOW}⚠${NC} (already installed or failed)"
  fi
done

log_success "Essential tools installed"

# ============================================================================
# Step 3: Install Runtimes
# ============================================================================

log_step "Installing Node.js..."
if ! command -v node &> /dev/null; then
  if pkg install -y nodejs > /dev/null 2>&1; then
    log_success "Node.js installed: $(node --version)"
  else
    log_error "Failed to install Node.js"
  fi
else
  log_success "Node.js already installed: $(node --version)"
fi

log_step "Installing Python..."
if ! command -v python &> /dev/null; then
  if pkg install -y python > /dev/null 2>&1; then
    log_success "Python installed: $(python --version)"
  else
    log_error "Failed to install Python"
  fi
else
  log_success "Python already installed: $(python --version)"
fi

log_step "Installing Rust (optional)..."
if ! command -v rustc &> /dev/null; then
  echo "Rust installation may take a while..."
  if pkg install -y rust > /dev/null 2>&1; then
    log_success "Rust installed: $(rustc --version)"
  else
    log_error "Failed to install Rust (optional)"
  fi
else
  log_success "Rust already installed: $(rustc --version)"
fi

# ============================================================================
# Step 4: Create Directories
# ============================================================================

log_step "Creating standard directories..."

mkdir -p ~/.local/bin
mkdir -p ~/.config
mkdir -p ~/projects
mkdir -p ~/storage/documents

log_success "Directories created"

# ============================================================================
# Step 5: Install Claude Code
# ============================================================================

log_step "Installing Claude Code..."

if ! command -v claude-code &> /dev/null; then
  echo "Attempting to install via npm..."
  if npm install -g @anthropic-ai/claude-code > /dev/null 2>&1; then
    log_success "Claude Code installed: $(claude-code --version)"
  else
    log_error "Failed to install Claude Code via npm"
    echo "Try installing manually:"
    echo "  npm install -g @anthropic-ai/claude-code"
  fi
else
  log_success "Claude Code already installed: $(claude-code --version)"
fi

# ============================================================================
# Step 6: Configure Bash
# ============================================================================

log_step "Configuring shell environment..."

# Check if .bashrc exists
if [ ! -f "$HOME/.bashrc" ]; then
  touch "$HOME/.bashrc"
  log_success "Created ~/.bashrc"
fi

# Add custom configuration if not already there
if ! grep -q "# Claude Code on Android" "$HOME/.bashrc"; then
  cat >> "$HOME/.bashrc" << 'EOF'

# Claude Code on Android - Custom Configuration
# Useful aliases
alias cl="claude-code"
alias cls="claude-code stats"

# Display useful info
echo "🚀 Claude Code on Android/Termux Ready"
echo "   Node: $(node --version)"
echo "   Python: $(python --version)"

EOF
  log_success "Added Claude Code aliases to ~/.bashrc"
else
  log_success "Claude Code configuration already exists in ~/.bashrc"
fi

# ============================================================================
# Step 7: Configure Git
# ============================================================================

log_step "Configuring Git..."

GIT_USER=$(git config --global user.name 2>/dev/null)
GIT_EMAIL=$(git config --global user.email 2>/dev/null)

if [ -z "$GIT_USER" ] || [ -z "$GIT_EMAIL" ]; then
  echo "Git configuration needed for commits."
  echo ""
  read -p "Enter your Git username: " git_user
  read -p "Enter your Git email: " git_email

  git config --global user.name "$git_user"
  git config --global user.email "$git_email"

  log_success "Git configured with user: $git_user"
else
  log_success "Git already configured: $GIT_USER <$GIT_EMAIL>"
fi

# ============================================================================
# Step 8: Ask for API Key
# ============================================================================

log_step "Configuring API Key..."

if [ -z "$ANTHROPIC_API_KEY" ]; then
  echo ""
  echo "Claude Code needs an API key to work."
  echo "Get your key at: https://console.anthropic.com/"
  echo ""
  read -p "Enter your API key (or press Enter to skip): " api_key

  if [ -n "$api_key" ]; then
    # Add to .bashrc
    echo "export ANTHROPIC_API_KEY='$api_key'" >> "$HOME/.bashrc"
    log_success "API key configured"
    echo "Note: Reload shell with: source ~/.bashrc"
  else
    log_error "API key not configured (you can add it later)"
  fi
else
  log_success "ANTHROPIC_API_KEY already set"
fi

# ============================================================================
# Step 9: Setup Storage (if Termux)
# ============================================================================

if [ -d "/data/data/com.termux" ]; then
  log_step "Checking Termux storage setup..."

  if [ -d "$HOME/storage" ]; then
    log_success "Storage already configured"
  else
    echo "Storage needs to be configured for Termux."
    echo "This will open a permission dialog."
    echo ""
    read -p "Press Enter to continue..." -t 5

    termux-setup-storage 2>/dev/null || log_error "Storage setup failed"
  fi
fi

# ============================================================================
# Summary
# ============================================================================

echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║                    Installation Complete!                      ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""

echo "✓ Environment is ready for Claude Code!"
echo ""
echo "Next steps:"
echo "  1. Reload your shell: source ~/.bashrc"
echo "  2. Verify installation: bash scripts/verify.sh"
echo "  3. Start using Claude Code:"
echo "     claude-code --help"
echo "     claude-code 'your task here'"
echo ""
echo "For detailed documentation, see:"
echo "  • README.md - Project overview"
echo "  • SETUP.md - Detailed setup guide"
echo "  • KNOWN_ISSUES.md - Known limitations and workarounds"
echo ""
echo "Happy coding! 🚀"
echo ""
