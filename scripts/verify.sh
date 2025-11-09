#!/bin/bash

# Claude Code on Android/Termux - Verification Script
# Purpose: Check if everything is properly installed and configured
# Usage: bash scripts/verify.sh

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
PASSED=0
FAILED=0
WARNINGS=0

echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Claude Code on Android/Termux - Verification Script        ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Test function
test_component() {
  local name="$1"
  local command="$2"
  local expected_version="$3"

  echo -ne "Checking ${name}... "

  if eval "$command" > /dev/null 2>&1; then
    local version=$(eval "$command" 2>&1 | head -1)
    echo -e "${GREEN}✓ PASS${NC} ($version)"
    ((PASSED++))
  else
    echo -e "${RED}✗ FAIL${NC}"
    ((FAILED++))
  fi
}

test_file() {
  local name="$1"
  local path="$2"

  echo -ne "Checking ${name}... "

  if [ -f "$path" ]; then
    echo -e "${GREEN}✓ PASS${NC}"
    ((PASSED++))
  else
    echo -e "${RED}✗ FAIL${NC} (Not found: $path)"
    ((FAILED++))
  fi
}

# ============================================================================
# SYSTEM CHECKS
# ============================================================================

echo -e "${BLUE}[System Environment]${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo -ne "Platform... "
OS=$(uname -s)
if [[ "$OS" == "Linux" ]]; then
  ARCH=$(uname -m)
  echo -e "${GREEN}✓ PASS${NC} (Linux $ARCH)"
  ((PASSED++))
else
  echo -e "${RED}✗ FAIL${NC} (Expected Linux, got $OS)"
  ((FAILED++))
fi

echo -ne "Termux environment... "
if [ -d "/data/data/com.termux" ]; then
  echo -e "${GREEN}✓ PASS${NC}"
  ((PASSED++))
else
  echo -e "${YELLOW}! WARNING${NC} (Not running in Termux)"
  ((WARNINGS++))
fi

echo -ne "Home directory... "
if [ -n "$HOME" ] && [ -d "$HOME" ]; then
  echo -e "${GREEN}✓ PASS${NC} ($HOME)"
  ((PASSED++))
else
  echo -e "${RED}✗ FAIL${NC} (Invalid HOME)"
  ((FAILED++))
fi

echo -ne "Storage access... "
if [ -d "$HOME/storage" ]; then
  echo -e "${GREEN}✓ PASS${NC}"
  ((PASSED++))
else
  echo -e "${YELLOW}! WARNING${NC} (Storage not set up - run: termux-setup-storage)"
  ((WARNINGS++))
fi

# ============================================================================
# RUNTIME CHECKS
# ============================================================================

echo ""
echo -e "${BLUE}[Runtime Environments]${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

test_component "Node.js" "node --version"
test_component "npm" "npm --version"
test_component "Python" "python --version"
test_component "Python3" "python3 --version"
test_component "pip" "pip --version"

echo -ne "Checking Rust... "
if command -v rustc > /dev/null 2>&1; then
  local version=$(rustc --version)
  echo -e "${GREEN}✓ PASS${NC} ($version)"
  ((PASSED++))
else
  echo -e "${YELLOW}! OPTIONAL${NC} (Rust not installed)"
  ((WARNINGS++))
fi

test_component "Git" "git --version"

# ============================================================================
# CLAUDE CODE CHECKS
# ============================================================================

echo ""
echo -e "${BLUE}[Claude Code Installation]${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo -ne "Checking claude-code command... "
if command -v claude-code > /dev/null 2>&1; then
  local version=$(claude-code --version 2>&1 | head -1)
  echo -e "${GREEN}✓ PASS${NC} ($version)"
  ((PASSED++))
else
  echo -e "${RED}✗ FAIL${NC} (claude-code not found in PATH)"
  ((FAILED++))
fi

echo -ne "Checking claude-code help... "
if claude-code --help > /dev/null 2>&1; then
  echo -e "${GREEN}✓ PASS${NC}"
  ((PASSED++))
else
  echo -e "${RED}✗ FAIL${NC} (claude-code --help failed)"
  ((FAILED++))
fi

# ============================================================================
# API KEY CHECKS
# ============================================================================

echo ""
echo -e "${BLUE}[API Configuration]${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo -ne "Checking ANTHROPIC_API_KEY... "
if [ -n "$ANTHROPIC_API_KEY" ]; then
  local key_prefix="${ANTHROPIC_API_KEY:0:7}"
  echo -e "${GREEN}✓ PASS${NC} (Set to: ${key_prefix}...)"
  ((PASSED++))
else
  echo -e "${YELLOW}! WARNING${NC} (Not set - configure in ~/.bashrc)"
  ((WARNINGS++))
fi

echo -ne "Checking OPENAI_API_KEY... "
if [ -n "$OPENAI_API_KEY" ]; then
  local key_prefix="${OPENAI_API_KEY:0:7}"
  echo -e "${GREEN}✓ PASS${NC} (Set to: ${key_prefix}...)"
  ((PASSED++))
else
  echo -e "${YELLOW}! OPTIONAL${NC} (Not set - only needed for OpenAI)"
  ((WARNINGS++))
fi

# ============================================================================
# ESSENTIAL FILES
# ============================================================================

echo ""
echo -e "${BLUE}[Essential Files]${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

test_file ".bashrc" "$HOME/.bashrc"
test_file ".gitconfig" "$HOME/.gitconfig"

echo -ne "Checking ~/.local/bin... "
if [ -d "$HOME/.local/bin" ]; then
  echo -e "${GREEN}✓ PASS${NC}"
  ((PASSED++))
else
  echo -e "${YELLOW}! WARNING${NC} (Not found - create with: mkdir -p ~/.local/bin)"
  ((WARNINGS++))
fi

# ============================================================================
# GIT CONFIGURATION
# ============================================================================

echo ""
echo -e "${BLUE}[Git Configuration]${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo -ne "Git user.name... "
local git_user=$(git config --global user.name 2>/dev/null)
if [ -n "$git_user" ]; then
  echo -e "${GREEN}✓ PASS${NC} ($git_user)"
  ((PASSED++))
else
  echo -e "${YELLOW}! WARNING${NC} (Not configured - run: git config --global user.name 'Your Name')"
  ((WARNINGS++))
fi

echo -ne "Git user.email... "
local git_email=$(git config --global user.email 2>/dev/null)
if [ -n "$git_email" ]; then
  echo -e "${GREEN}✓ PASS${NC} ($git_email)"
  ((PASSED++))
else
  echo -e "${YELLOW}! WARNING${NC} (Not configured - run: git config --global user.email 'email@example.com')"
  ((WARNINGS++))
fi

# ============================================================================
# OPTIONAL COMPONENTS
# ============================================================================

echo ""
echo -e "${BLUE}[Optional Components]${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo -ne "Checking SSH key... "
if [ -f "$HOME/.ssh/id_ed25519" ]; then
  echo -e "${GREEN}✓ PASS${NC}"
  ((PASSED++))
else
  echo -e "${YELLOW}! OPTIONAL${NC} (SSH key not found - generate with: ssh-keygen -t ed25519)"
  ((WARNINGS++))
fi

echo -ne "Checking vim... "
if command -v vim > /dev/null 2>&1; then
  echo -e "${GREEN}✓ PASS${NC}"
  ((PASSED++))
else
  echo -e "${YELLOW}! OPTIONAL${NC} (Not installed - install with: pkg install vim)"
  ((WARNINGS++))
fi

echo -ne "Checking zsh... "
if command -v zsh > /dev/null 2>&1; then
  echo -e "${GREEN}✓ PASS${NC}"
  ((PASSED++))
else
  echo -e "${YELLOW}! OPTIONAL${NC} (Not installed - install with: pkg install zsh)"
  ((WARNINGS++))
fi

# ============================================================================
# SUMMARY
# ============================================================================

echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║                       VERIFICATION SUMMARY                     ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"

TOTAL=$((PASSED + FAILED + WARNINGS))

printf "%-30s %s\n" "Checks Passed:" "$(printf '%2d' $PASSED) / $TOTAL"
if [ $FAILED -gt 0 ]; then
  printf "%-30s %s\n" "Critical Failures:" "$(printf '%2d' $FAILED)"
fi
if [ $WARNINGS -gt 0 ]; then
  printf "%-30s %s\n" "Warnings:" "$(printf '%2d' $WARNINGS)"
fi

echo ""

# Final status
if [ $FAILED -eq 0 ]; then
  echo -e "${GREEN}✓ Verification successful!${NC}"
  echo ""
  echo "You can now use Claude Code:"
  echo "  claude-code --help"
  echo "  claude-code 'your task here'"
  echo ""
  exit 0
else
  echo -e "${RED}✗ Some checks failed. Please review above and fix issues.${NC}"
  echo ""
  echo "Common fixes:"
  echo "  • API key: Add to ~/.bashrc: export ANTHROPIC_API_KEY='your-key'"
  echo "  • Storage: Run: termux-setup-storage"
  echo "  • PATH: Add to ~/.bashrc: export PATH=\$PATH:~/.local/bin"
  echo "  • Git config: Run: git config --global user.name 'Your Name'"
  echo ""
  echo "See SETUP.md for detailed instructions."
  echo ""
  exit 1
fi
