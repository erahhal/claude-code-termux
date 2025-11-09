# 🚀 Claude Code on Android/Termux

**Make Claude Code work flawlessly on your Android device using Termux and PRoot.**

## The Problem

Anthropic's Claude Code is powerful for developers, but it's officially only available for Desktop (macOS/Windows) and Web. **Mobile developers are excluded.**
 
Users want to:
- Develop on their phones/tablets
- Use Claude Code without a laptop
- Have a portable, always-available development environment
- Leverage their ARM64 mobile devices for actual programming

## The Solution

This repository provides **complete, tested instructions** to run Claude Code natively on Android via Termux (an open-source terminal emulator). Everything is documented, automated, and verified to work.

**What you get:**
- ✅ Full Claude Code CLI on your Android device
- ✅ Local development environment (Node.js, Python, Rust)
- ✅ MCP (Model Context Protocol) support
- ✅ Git version control
- ✅ WebSocket-based tools
- ✅ Direct system access via Bash

**Known limitations:**
- ⚠️ Some Claude Code features not yet supported on Termux (documented)
- ⚠️ Performance depends on device hardware
- ⚠️ No official Anthropic support (yet)

## Quick Start

```bash
# 1. Install Termux from F-Droid (Google Play version may have restrictions)
# Available at: https://f-droid.org/packages/com.termux/

# 2. Clone this repository
git clone https://github.com/eduterre/claude-code-termux.git
cd claude-code-termux

# 3. Run the automated setup
bash scripts/install.sh

# 4. Verify installation
bash scripts/verify.sh

# 5. Use Claude Code!
claude-code --help
```

**For detailed step-by-step instructions**, see [SETUP.md](./SETUP.md)

## What Works ✅

| Feature | Status | Notes |
|---------|--------|-------|
| Claude Code CLI | ✅ Fully working | Core functionality intact |
| Bash execution | ✅ Full support | System command access |
| File operations | ✅ Full support | Read, write, edit files |
| Git operations | ✅ Full support | Clone, commit, push |
| MCP Protocol | ✅ Working | Stdio communication working |
| Code analysis | ✅ Full support | Glob, grep, codebase understanding |
| Task execution | ✅ Working | Multi-step operations |
| Node.js 24.9.0 | ✅ Working | Latest stable version |
| Python 3.12.12 | ✅ Working | Latest stable version |
| Rust 1.90.0 | ✅ Working | Latest stable version |

## Known Issues ⚠️

| Issue | Impact | Workaround | Status |
|-------|--------|-----------|--------|
| Custom Slash Commands disabled | Medium | Use standard commands | [#9435](https://github.com/anthropics/claude-code/issues/9435) |
| Image reading in terminal | Low | Manual image handling | [#2248](https://github.com/anthropics/claude-code/issues/2248) |
| Performance on older devices | High | Use device with 4GB+ RAM | Device-dependent |
| WebAssembly support missing | Low | Not required for CLI | [#2248](https://github.com/anthropics/claude-code/issues/2248) |

**Full list and workarounds:** See [KNOWN_ISSUES.md](./KNOWN_ISSUES.md)

## Why This Matters

### For Developers
- Write code anywhere, anytime
- Leverage Claude AI on the go
- No laptop required
- Education and learning on mobile

### For Anthropic
- **Validates mobile developer market** - Real demand exists
- **Identifies gaps** - Shows what needs official support
- **Expands reach** - Mobile is the dominant computing platform
- **Community engagement** - Users invested in Claude ecosystem

### Statistics
- ~3+ years of PRoot/Termux ecosystem development
- 6+ documented GitHub issues for Termux support
- Community members writing guides (proof of demand)
- This repo: **A-Z tested, fully documented setup**

## Testing Results

This repository includes comprehensive testing data:

- **Compatibility Matrix**: Tested on multiple Android versions and device types
- **Performance Benchmarks**: CPU/Memory/Startup time on ARM64
- **Feature Checklist**: Exactly what works on Termux vs Desktop
- **Troubleshooting Guide**: Solutions for common problems

See [test-results/](./test-results/) for full details.

## Repository Structure

```
claude-code-termux/
├── README.md                          # This file
├── SETUP.md                           # Complete A-Z installation guide
├── KNOWN_ISSUES.md                    # Honest limitation documentation
├── CONTRIBUTING.md                    # How to help improve this
├── LICENSE                            # MIT License
│
├── scripts/                           # Automation
│   ├── install.sh                     # Automated setup
│   ├── verify.sh                      # System verification
│   ├── test-claude-code.sh            # Feature testing
│   └── troubleshoot.sh                # Diagnostic tools
│
├── docs/                              # Detailed documentation
│   ├── architecture.md                # System architecture
│   ├── termux-setup.md                # Termux-specific setup
│   ├── proot-optimization.md          # Performance tuning
│   ├── api-keys-securely.md           # Security best practices
│   ├── claude-code-on-mobile.md       # Mobile-specific behavior
│   └── integration-with-projects.md   # Using with your projects
│
├── examples/                          # Usage examples
│   ├── minimal-setup/                 # Bare minimum setup
│   ├── troubleshooting/               # Common problems + solutions
│   └── showcase/                      # Example projects
│
├── test-results/                      # Testing & verification
│   ├── compatibility-matrix.md        # OS/device compatibility
│   ├── feature-checklist.md           # Feature support status
│   └── performance-benchmarks.md      # Speed & resource usage
│
└── .github/                           # GitHub-specific
    ├── ISSUE_TEMPLATE/
    │   ├── bug_report.md
    │   └── feature_request.md
    └── workflows/                     # CI/CD (optional)
```

## Getting Help

1. **New to Termux?** → Start with [SETUP.md](./SETUP.md)
2. **Something broke?** → See [KNOWN_ISSUES.md](./KNOWN_ISSUES.md) or [Troubleshooting Guide](./docs/troubleshooting.md)
3. **Found a bug?** → Open an issue with the [bug report template](./.github/ISSUE_TEMPLATE/bug_report.md)
4. **Have a workaround?** → Share it in Discussions or submit a PR
5. **Want to help?** → See [CONTRIBUTING.md](./CONTRIBUTING.md)

## Contributing

This project is community-driven. Contributions are welcome!

- 📝 Improve documentation
- 🐛 Report bugs with detailed reproduction steps
- ✨ Share workarounds you discovered
- 🧪 Test on different devices and Android versions
- 🚀 Suggest improvements

See [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines.

## Reaching Anthropic

This repository is designed to demonstrate:

1. **Real-world demand** for Claude Code on mobile
2. **Functional proof** that it can work
3. **Community interest** and engagement
4. **Known limitations** that need official attention

We're not asking for perfection — we're showing the market opportunity and specific gaps that Anthropic could address.

**Issues to watch in the Anthropic repo:**
- [#9435 - Custom Slash Commands on Termux](https://github.com/anthropics/claude-code/issues/9435)
- [#2248 - WebAssembly/Image support for Android](https://github.com/anthropics/claude-code/issues/2248)

## License

MIT License - See [LICENSE](./LICENSE) for details.

**TL;DR**: Use this freely, modify it, share it. Just give credit.

## Disclaimer

This is a **community project**, not officially supported by Anthropic. Use at your own risk. See [LICENSE](./LICENSE) and [KNOWN_ISSUES.md](./KNOWN_ISSUES.md) for limitations.

---

## The Ask to Anthropic 👋

Dear Anthropic team,

Developers want to use Claude Code on their phones. This repository proves:

1. **It's technically possible** ✅
2. **People want it badly** (6+ GitHub issues, community guides)
3. **Specific gaps are known** (documented with issue links)
4. **A working implementation exists** (this repo)

**What would help:**
- Official Termux support (at least to fix known issues)
- Better documentation of mobile limitations
- Prioritize #9435 and #2248
- Acknowledge the mobile developer market

We're not asking for full feature parity. We're asking you to **acknowledge the use case and help close the gaps**.

Thank you,
**The Community**

---

**Made with ❤️ by [Eduard Terre](https://github.com/eduterre), for developers everywhere.**

**Connect**:
- 🐙 GitHub: [@eduterre](https://github.com/eduterre)
- 💼 LinkedIn: [Eduard Terre](https://linkedin.com/in/eduard-terre)
- 📧 Email: terre.eduard@hotmail.com

Last updated: November 2025
