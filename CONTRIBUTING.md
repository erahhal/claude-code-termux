# 🤝 Contributing to Claude Code on Android/Termux

Thank you for your interest in making Claude Code work better on mobile! This document explains how you can help.

## Ways to Contribute

### 1. Report Issues 🐛

Found a bug or problem? Help us fix it!

**Before reporting:**
- Check [KNOWN_ISSUES.md](./KNOWN_ISSUES.md) - your issue might be documented
- Search existing GitHub issues to avoid duplicates
- Test on a clean installation if possible
- Note the exact steps to reproduce

**To report an issue:**
1. Click "Issues" tab on GitHub
2. Click "New Issue"
3. Use the bug report template
4. Include:
   - Device and Android version
   - Termux version
   - What you expected vs what happened
   - Exact steps to reproduce
   - Error messages and logs

**Example**:
```
Device: Samsung Galaxy S21
Android: 13
Termux: 0.118.0
Node.js: v24.9.0
Python: 3.12.12

Issue: Claude Code times out when analyzing large codebases

Steps to reproduce:
1. Clone a large project (>10K files)
2. Run: claude-code "analyze this codebase"
3. Wait 5 minutes
4. Get timeout error

Expected: Analysis completes or shows progress
Actual: Timeout after 5 minutes with no error message
```

### 2. Share Workarounds 💡

Discovered a fix or workaround for an issue?

**To contribute a workaround:**
1. Open an issue with tag `workaround`
2. Describe the problem clearly
3. Explain your solution in detail
4. Include steps others can follow
5. Mention if you tested it on multiple devices

**Example**:
```
Workaround for: Custom slash commands not working on Termux

Problem: /commit command doesn't work

Solution: Use standard claude-code commands instead
- Instead of: /commit "message"
- Use: claude-code "commit these changes with message: 'message'"

Steps:
1. Open any project
2. Make some changes
3. Run: claude-code "commit with message: 'Test commit'"
4. Watch it work!

Tested on: Pixel 5 (Android 13), Galaxy S21 (Android 12)
```

### 3. Improve Documentation 📚

Found a typo, unclear instructions, or missing information?

**To improve docs:**
1. Fork the repository
2. Edit the `.md` files directly
3. Test your changes if it's a guide
4. Submit a Pull Request

**Common improvements:**
- Fix typos or grammar
- Clarify confusing sections
- Add helpful examples
- Improve formatting
- Add links to resources

### 4. Test on Different Devices 📱

We need to know if setup works on various devices!

**To help with testing:**
1. Go through [SETUP.md](./SETUP.md) on your device
2. Run [scripts/verify.sh](./scripts/verify.sh)
3. Document your results
4. Create an issue with results

**Testing template**:
```
Device Testing Report

Device: [Model and specs]
Android Version: [e.g., 13, 12.1]
Termux Version: [e.g., 0.118.0]
Device RAM: [e.g., 6GB, 8GB]

Installation Results:
- Node.js: ✓ / ✗
- Python: ✓ / ✗
- Rust: ✓ / ✗
- Claude Code: ✓ / ✗

Performance:
- Startup time: [e.g., 2 seconds]
- Memory usage: [e.g., 150MB]
- First command execution: [e.g., 5 seconds]

Issues encountered:
1. [Issue 1]
2. [Issue 2]

Suggestions:
- [Suggestion 1]
```

### 5. Create Setup Guides for Variants 🔧

Want to create guides for specific setups?

**Possible guides:**
- Using with specific IDEs (Termux editors)
- Advanced setup with Docker (if possible)
- Integration with other development tools
- Device-specific optimizations
- Using with specific coding frameworks

**To contribute a guide:**
1. Create a new `.md` file in `docs/`
2. Follow the format of existing guides
3. Include prerequisites, step-by-step instructions, troubleshooting
4. Submit a Pull Request

### 6. Contribute Code Improvements 💻

Want to improve the scripts?

**Before coding:**
1. Open an issue describing the improvement
2. Discuss approach with maintainers
3. Wait for approval

**When contributing code:**
1. Fork the repository
2. Create a feature branch: `git checkout -b improve/feature-name`
3. Make your changes
4. Test thoroughly
5. Commit with clear message: `git commit -m "Improve X feature"`
6. Push: `git push origin improve/feature-name`
7. Open a Pull Request

**Code guidelines:**
- Use clear variable names
- Add comments for complex sections
- Test on actual device before submitting
- Include error handling
- Follow existing style

### 7. Help with GitHub Infrastructure 🏗️

**Need help with:**
- Issue templates
- Automated workflows (GitHub Actions)
- Documentation site (if created)
- CI/CD setup for testing

---

## Pull Request Process

1. **Fork the repository** on GitHub
2. **Create a feature branch**: `git checkout -b feature/your-feature`
3. **Make your changes** - keep commits focused
4. **Test your changes** thoroughly
5. **Commit with clear messages**: `git commit -m "Add/Fix/Improve X"`
6. **Push to your fork**: `git push origin feature/your-feature`
7. **Open a Pull Request** on the main repository
8. **Respond to feedback** and iterate if needed
9. **Merge!** 🎉

**PR Guidelines:**
- One feature per PR (don't mix unrelated changes)
- Clear description of what changed and why
- Link related issues
- Test on actual device
- Follow existing code style
- Keep commits clean and descriptive

---

## Communication

### Discussions

Have ideas or questions? Use GitHub Discussions:
- Ask for advice
- Suggest features
- Share experiences
- Brainstorm together

### Issues

Use issues for:
- Bugs and problems
- Feature requests
- Documentation improvements
- Testing results

### Code of Conduct

Be respectful and constructive:
- ✅ Do: Be helpful, kind, and constructive
- ✅ Do: Respect different opinions
- ✅ Do: Test before reporting
- ❌ Don't: Be rude or dismissive
- ❌ Don't: Report issues without detail
- ❌ Don't: Spam or self-promote

---

## Recognition

We value all contributions! Contributors will be:
- Listed in [CONTRIBUTORS.md](./CONTRIBUTORS.md) (coming soon)
- Thanked in relevant documentation
- Credited in commit messages
- Recognized in release notes

---

## What We Need Most Right Now

**High Priority:**
1. 🧪 **Device Testing** - Test on various Android versions and devices
2. 📝 **Documentation** - Improve guides, fix typos, add examples
3. 🐛 **Bug Reports** - Find and document new issues
4. 💡 **Workarounds** - Share solutions you discover

**Medium Priority:**
5. 📚 **Advanced Guides** - Create specialized setup guides
6. 🔧 **Script Improvements** - Enhance install/verify scripts
7. 🏗️ **Infrastructure** - GitHub templates and automation

**Nice to Have:**
8. 💻 **Code Contributions** - New features or improvements
9. 🎨 **Design** - Visual improvements or branding
10. 📢 **Outreach** - Help spread the word

---

## Getting Help

**Questions or stuck?**
1. Check [README.md](./README.md)
2. Review [SETUP.md](./SETUP.md)
3. See [KNOWN_ISSUES.md](./KNOWN_ISSUES.md)
4. Open a GitHub Discussion
5. Comment on a related issue

---

## Attribution

By contributing, you agree that:
- Your contributions can be used under the MIT license
- You grant the project rights to use your work
- You're not including copyrighted material

---

## Special Thanks

This project exists because of community demand. Every contribution — whether code, docs, or testing — brings Claude Code closer to official mobile support.

**Thank you for being part of the journey! 🚀**

---

Last updated: November 2025
