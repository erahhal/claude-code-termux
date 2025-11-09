# ⚠️ Known Issues and Limitations

This document honestly lists what **doesn't work** on Claude Code for Android/Termux and suggests workarounds.

**Philosophy**: We're not hiding problems — we're documenting them to help Anthropic understand what needs fixing.

---

## Critical Issues

### 1. Custom Slash Commands Disabled

**Severity**: 🔴 **HIGH** - Limits extensibility
**Issue Link**: https://github.com/anthropics/claude-code/issues/9435
**Status**: Open (Anthropic aware)

**Problem**:
- Custom slash commands (like `/commit`, `/review`, `/plan`) don't work on Termux
- This was a workaround issue from earlier releases
- Agents that rely on slash commands fail

**Impact**:
- Can't use community-created tools
- Advanced workflows limited
- Extensibility is severely restricted

**Workaround**:
```bash
# Instead of custom commands, use standard commands:

# Instead of: /commit "message"
claude-code "commit these changes with message: 'your message'"

# Instead of: /review
claude-code "review this code for issues"

# Instead of: /plan [task]
claude-code "create a plan for: [task]"
```

**When Fixed**: Unknown - Requires Anthropic to investigate Termux-specific environment issues

---

### 2. Image Reading / WebAssembly Support Missing

**Severity**: 🟡 **MEDIUM** - Limits code analysis capabilities
**Issue Link**: https://github.com/anthropics/claude-code/issues/2248
**Status**: Open (Anthropic aware)

**Problem**:
- Claude Code can't read images directly in Termux
- Missing WebAssembly support for image sharp binaries
- Android ARM64 platform doesn't have precompiled `sharp` module
- Error: `sharp prebuilt binaries are not available for your platform`

**Impact**:
- Can't analyze screenshots
- Can't process design files
- Can't debug UI issues with images

**Workaround**:
```bash
# Option 1: Convert image to text description
# Manually describe the image to Claude Code:
claude-code "I have a screenshot showing [describe what you see], how would you fix this?"

# Option 2: Use external tool to extract text from images
# Install OCR tool:
pkg install tesseract

# Extract text from image:
tesseract image.png output

# Then pass extracted text to Claude Code:
claude-code "analyze this text from a screenshot: [text]"

# Option 3: Use Claude Web interface for image analysis
# Paste the image in web interface, then use results in Termux
```

**When Fixed**: Requires Anthropic to provide Android ARM64 binaries for `sharp` library

---

## Performance Issues

### 3. Slow Performance on Older/Mid-Range Devices

**Severity**: 🟡 **MEDIUM** - Affects user experience
**Issue Link**: None (device-dependent)
**Status**: Won't fix (hardware limitation)

**Problem**:
- Devices with <4GB RAM experience slowness
- ARM64 CPUs are slower than desktop processors
- Rust compilation is very slow on mobile
- Large file operations take time

**Typical Performance**:
- Small operations: 2-5 seconds
- Medium operations: 5-15 seconds
- Large compilations: 30+ seconds to minutes
- Startup time: 1-3 seconds

**Workaround**:
```bash
# Monitor system resources
htop

# Close background apps before using Claude Code

# For compilation:
# Use pre-built binaries instead of compiling
# E.g., don't `cargo build`, use already-built executables

# For large files:
# Split work into smaller chunks
# Process one file at a time instead of bulk operations
```

**Hardware Recommendation**:
- **Minimum**: 4GB RAM, Snapdragon 800 series or equivalent
- **Recommended**: 8GB RAM, Snapdragon 888 or newer / Apple A15+

---

### 4. Storage I/O Bottleneck

**Severity**: 🟡 **MEDIUM** - Affects large projects
**Issue Link**: None (device hardware)
**Status**: Won't fix (hardware limitation)

**Problem**:
- Android storage (eMMC or UFS) slower than desktop SSDs
- Large git operations slow
- npm/pip installs slower than desktop

**Workaround**:
```bash
# Use faster storage options
# Some devices support external microSD cards:
ln -s /mnt/sdcard ~/fast-storage

# For large projects:
# Work on smaller repositories
# Clone only needed branches:
git clone --depth 1 --branch main https://github.com/user/repo.git

# Parallel downloads:
npm install --prefer-offline --no-audit
```

---

## Functionality Issues

### 5. File Permissions Edge Cases

**Severity**: 🟢 **LOW** - Rare edge cases
**Issue Link**: None specific
**Status**: Workaround available

**Problem**:
- Android filesystem has different permission model
- Some edge cases with executable permissions
- Shell script execution sometimes fails

**Workaround**:
```bash
# Explicitly set permissions before running
chmod +x script.sh

# Run with explicit shell
bash script.sh

# Or use full path
/system/bin/sh script.sh
```

---

### 6. Git Operations with Special Characters

**Severity**: 🟢 **LOW** - Rare edge cases
**Issue Link**: None specific
**Status**: Workaround available

**Problem**:
- Some special characters in filenames cause issues
- Emoji in commit messages sometimes fail
- Non-ASCII characters may not display correctly

**Workaround**:
```bash
# Use ASCII-only filenames and commit messages
# Instead of: "Update 🎨 UI"
# Use: "Update UI"

# For special chars in filenames:
# Rename with ASCII only
mv "file-🎨.js" "file-ui.js"

# In commits: Use descriptions instead of emoji
# Instead of: "Fix 🐛 bug"
# Use: "Fix bug in authentication"
```

---

### 7. TLS/SSL Certificate Issues (Rare)

**Severity**: 🟢 **LOW** - Happens with corporate networks
**Issue Link**: None specific
**Status**: Workaround available

**Problem**:
- Some corporate networks intercept HTTPS
- Certificate verification sometimes fails
- GitHub/npm registry access blocked

**Workaround**:
```bash
# Update certificate store
pkg install ca-certificates
update-ca-certificates

# For git operations behind proxy:
git config --global http.sslVerify false  # Use carefully!

# Or configure proxy
git config --global http.proxy http://[proxy-server]:8080

# For npm behind corporate network:
npm config set registry https://registry.npmjs.org/
npm config set strict-ssl false  # Use carefully!
```

**Note**: Only disable SSL verification on trusted networks.

---

## Environment-Specific Issues

### 8. PATH and Environment Variable Issues

**Severity**: 🟢 **LOW** - Configuration issue
**Issue Link**: None specific
**Status**: Workaround available

**Problem**:
- PATH doesn't persist between Termux sessions sometimes
- Environment variables lose values after shell restart
- Some scripts inherit wrong environment

**Workaround**:
```bash
# Add to ~/.bashrc (or ~/.zshrc for Zsh):
export PATH=$PATH:~/.local/bin:~/.cargo/bin

# Make it persistent:
nano ~/.bashrc
# Add PATH export
# Save with Ctrl+X, Y, Enter

# Reload immediately:
source ~/.bashrc

# Verify:
echo $PATH

# For individual scripts, source your bashrc first:
#!/bin/bash
source ~/.bashrc
# rest of script
```

---

### 9. Session Persistence Issues

**Severity**: 🟢 **LOW** - Rare during development
**Issue Link**: None specific
**Status**: Workaround available

**Problem**:
- Long-running processes may timeout
- Network interruptions break long operations
- Termux app backgrounding can interrupt processes

**Workaround**:
```bash
# For long operations, use screen or tmux:
pkg install screen

# Start a session
screen -S work

# Your operations here (survives backgrounding)

# Detach: Ctrl+A, D
# Reattach: screen -r work

# For git operations, ensure connection:
git config --global core.askpass /system/bin/true

# Use SSH instead of HTTPS for GitHub
# Configure SSH keys as per SETUP.md
```

---

## API and Provider Issues

### 10. Rate Limiting on Free API Keys

**Severity**: 🟡 **MEDIUM** - Affects heavy usage
**Issue Link**: Provider-specific
**Status**: Upgrade to paid plan

**Problem**:
- Anthropic free tier has rate limits
- OpenAI/Grok/DeepSeek have usage limits
- Multiple requests in succession may fail

**Impact**:
- Error: `Rate limit exceeded`
- Have to wait between operations

**Workaround**:
```bash
# Add delays between operations
claude-code "task 1"
sleep 5  # Wait 5 seconds
claude-code "task 2"

# Use batch operations to reduce request count
claude-code "do task 1, task 2, and task 3 in sequence"

# Switch to paid API key for higher limits
export ANTHROPIC_API_KEY="sk-ant-[paid-key]"
```

---

### 11. API Key Leakage Risk

**Severity**: 🔴 **CRITICAL** - Security issue
**Issue Link**: None (user responsibility)
**Status**: Best practice documentation

**Problem**:
- API keys in command history visible
- Accidental git commits of `.env` files
- Keys in logs

**Prevention**:
```bash
# Never commit .env files
echo ".env" >> ~/.gitignore

# Prevent keys in history
export HISTIGNORE="*ANTHROPIC_API_KEY*"

# Review before committing
git diff --cached | grep -i "sk-"

# If accidentally committed:
git rm --cached .env
git commit --amend
# (Don't do this on public repos - regenerate key!)
```

---

## Workaround Summary Table

| Issue | Severity | Workaround | Timeline |
|-------|----------|-----------|----------|
| Custom slash commands | HIGH | Use standard commands | Unknown |
| Image reading | MEDIUM | Manual description or OCR | Unknown |
| Slow performance | MEDIUM | Close apps, use better device | N/A |
| Storage slowness | MEDIUM | Split work, use depth-1 clones | N/A |
| File permissions | LOW | Explicit chmod | N/A |
| Special characters | LOW | Use ASCII only | N/A |
| TLS issues | LOW | Update certificates | N/A |
| PATH issues | LOW | Add to .bashrc | N/A |
| Long operations | LOW | Use screen/tmux | N/A |
| Rate limiting | MEDIUM | Paid plan or delays | N/A |
| Key leakage | CRITICAL | Gitignore + HISTIGNORE | N/A |

---

## Reporting New Issues

Found an issue not listed here?

1. **Test thoroughly**: Reproduce consistently
2. **Check existing issues**: Search in the Anthropic repo
3. **Gather info**:
   ```bash
   uname -a
   node --version
   python --version
   rustc --version
   claude-code --version
   echo $ANDROID_VERSION  # Android version
   ```
4. **Document steps**: Exact reproduction steps
5. **Post in repo**: Use issue template provided

---

## Contributing Workarounds

Have a workaround not listed? Help others!

1. Test it thoroughly
2. Document the exact steps
3. Submit a PR or open a discussion
4. Include: Problem, Solution, Steps, Verification

---

## Message to Anthropic

**What would help most**:
1. Fix #9435 (custom slash commands on Termux)
2. Fix #2248 (image support / WebAssembly for ARM64)
3. Add Termux to official supported platforms
4. Provide ARM64 prebuilt binaries for native modules
5. Document mobile-specific limitations officially

**We understand**:
- Mobile is not primary focus
- Full feature parity isn't expected
- This is community-driven initiative

**What we need**:
- Official acknowledgment of the use case
- Specific guidance on roadmap
- Help closing the critical gaps

---

**Last Updated**: November 2025
**Tested On**: Termux 0.118.0+, Android 12+, Anthropic Claude Code latest

For more info, see [README.md](./README.md) or [SETUP.md](./SETUP.md)
