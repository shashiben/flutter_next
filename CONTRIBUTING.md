# 🎉 Contributing to Flutter Next

First off, thank you for considering contributing to Flutter Next! 🚀 It's people like you that make this project awesome.

## 🌟 Welcome!

Whether you're fixing a bug, adding a feature, improving documentation, or just making the code cleaner - every contribution matters! We're excited to have you on board.

## 📋 Table of Contents

- [Code of Conduct](#-code-of-conduct)
- [Getting Started](#-getting-started)
- [How Can I Contribute?](#-how-can-i-contribute)
- [Development Setup](#-development-setup)
- [Coding Standards](#-coding-standards)
- [Commit Guidelines](#-commit-guidelines)
- [Pull Request Process](#-pull-request-process)
- [Project Structure](#-project-structure)

## 🤝 Code of Conduct

This project adheres to a code of conduct that all contributors are expected to follow. In short:

- **Be respectful** - We're all here to build something great together
- **Be inclusive** - Everyone's contributions are valued
- **Be constructive** - Feedback should help, not hurt
- **Be patient** - We all have different schedules and time zones

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Git
- A code editor (VS Code, Android Studio, or your favorite)

### Fork & Clone

1. **Fork the repository** 🍴
   - Click the "Fork" button on GitHub
   - This creates your own copy of the project

2. **Clone your fork** 📥
   ```bash
   git clone https://github.com/YOUR_USERNAME/flutter_next.git
   cd flutter_next
   ```

3. **Add upstream remote** 🔗
   ```bash
   git remote add upstream https://github.com/shashiben/flutter_next.git
   ```

## 💡 How Can I Contribute?

### 🐛 Reporting Bugs

Found a bug? Help us squash it! 🐞

**Before reporting:**
- Check if the issue already exists
- Make sure you're using the latest version
- Try to reproduce the issue

**When reporting:**
- Use a clear, descriptive title
- Describe the steps to reproduce
- Include expected vs actual behavior
- Add code examples, screenshots, or GIFs if helpful
- Mention your Flutter/Dart version

### ✨ Suggesting Features

Have an idea? We'd love to hear it! 💭

**When suggesting:**
- Check if the feature was already requested
- Explain the use case and why it's valuable
- Describe how it should work
- Consider edge cases

### 🔧 Contributing Code

Ready to code? Let's build something amazing! 💻

1. **Pick an issue** (or create one if needed)
2. **Comment on the issue** to let others know you're working on it
3. **Create a branch** from `main`:
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
   ```
4. **Make your changes**
5. **Test thoroughly**
6. **Submit a pull request**

## 🛠️ Development Setup

### Initial Setup

```bash
# Install melos (monorepo tool)
dart pub global activate melos

# Bootstrap all packages
melos bootstrap

# Or install dependencies for all packages
melos run all
```

### Running Examples

```bash
# Run animation_next example
cd animation_next/example
flutter run

# Run flutter_next example
cd flutter_next/example
flutter run
```

### Syncing Examples

The examples are shared between packages. Before committing, sync them:

```bash
melos run sync_examples
# or
bash scripts/sync_examples.sh
```

### Running Tests

```bash
# Run all tests
melos run test

# Run tests for a specific package
cd flutter_next
flutter test
```

## 📝 Coding Standards

### Dart Style Guide

- Follow the [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `dart format` to format your code
- Follow the existing code style in the project

### Code Formatting

```bash
# Format all code
dart format .

# Or use melos
melos run format
```

### Linting

We use `flutter_lints` for code quality. Make sure your code passes:

```bash
# Analyze all packages
melos run analyze

# Or for a specific package
cd animation_next
flutter analyze
```

### Documentation

- **Public APIs must be documented** 📚
- Use dartdoc comments for all public classes, methods, and properties
- Include examples in documentation when helpful
- Keep comments clear and concise

### Animation Guidelines

When adding new animations:

- **Use static curves** - Animations should determine their curves internally based on variant
- **Follow naming conventions** - Use `Next[AnimationType]Animation` pattern
- **Provide variants** - Add enum variants for different directions/effects
- **Test thoroughly** - Ensure animations work smoothly on all platforms
- **Document well** - Include usage examples in dartdoc

### Widget Guidelines

When adding new widgets:

- **Follow naming conventions** - Use `Next[WidgetName]` pattern
- **Make it responsive** - Consider different screen sizes
- **Provide variants** - Use enums for different styles
- **Add examples** - Include examples in the shared example app
- **Write tests** - Add unit/widget tests

## 📦 Project Structure

```
flutter_next/
├── animation_next/          # Animation package
│   ├── lib/
│   │   └── src/
│   │       ├── animations/  # Animation widgets
│   │       ├── enums.dart   # Animation variants
│   │       └── extensions/  # Extension methods
│   └── example/             # Example app (synced)
├── flutter_next/            # UI components package
│   ├── lib/
│   │   ├── views/           # Main widgets
│   │   ├── widgets/         # Helper widgets
│   │   ├── extensions/      # Extension methods
│   │   └── utils/           # Utility functions
│   └── example/             # Example app (synced)
├── example_shared/          # Shared example source
└── scripts/                 # Helper scripts
```

## 📝 Commit Guidelines

We follow [Conventional Commits](https://www.conventionalcommits.org/) for clear commit messages:

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

### Examples

```bash
feat(animation): add bounce animation variants
fix(button): correct hover state behavior
docs(readme): update installation instructions
style: format code with dart format
refactor(utils): simplify responsive breakpoint logic
```

### Tips

- Use present tense ("add" not "added")
- Use imperative mood ("move" not "moves")
- Keep the subject line under 50 characters
- Reference issues in the footer: `Closes #123`

## 🔄 Pull Request Process

### Before Submitting

- [ ] Code follows the style guidelines
- [ ] Code is properly formatted (`dart format`)
- [ ] All tests pass
- [ ] Documentation is updated
- [ ] Examples are synced (if applicable)
- [ ] CHANGELOG.md is updated (if needed)
- [ ] Commit messages follow the guidelines

### PR Checklist

1. **Update CHANGELOG.md** - Add your changes under "Unreleased"
2. **Update documentation** - If you added features or changed APIs
3. **Add tests** - If you added new functionality
4. **Sync examples** - If you modified the example app
5. **Run checks** - Make sure everything passes:
   ```bash
   melos run analyze
   melos run test
   melos run format
   ```

### PR Description Template

```markdown
## Description
Brief description of what this PR does

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
How was this tested?

## Screenshots (if applicable)
Add screenshots or GIFs

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
- [ ] Tests added/updated
- [ ] All tests pass
```

### Review Process

1. **Automated checks** run first (CI/CD)
2. **Maintainers review** your code
3. **Feedback is provided** - Don't worry, it's normal to have a few iterations!
4. **Once approved** - Your PR gets merged 🎉

## 🎯 Areas for Contribution

Looking for something to work on? Here are some ideas:

### 🐛 Good First Issues
- Look for issues tagged with `good first issue`
- These are perfect for newcomers!

### 📚 Documentation
- Improve README files
- Add code examples
- Fix typos or clarify explanations
- Add more usage examples

### 🧪 Testing
- Add missing tests
- Improve test coverage
- Add integration tests

### 🎨 UI/UX
- Improve example apps
- Add new example pages
- Enhance playground features

### ⚡ Performance
- Optimize animations
- Improve widget performance
- Reduce bundle size

## ❓ Questions?

- **GitHub Discussions** - For questions and discussions
- **GitHub Issues** - For bugs and feature requests
- **Pull Requests** - For code contributions

## 🙏 Thank You!

Your contributions make this project better for everyone. Whether you're fixing a typo, adding a feature, or improving documentation - **every contribution counts!** 

Happy coding! 🎉

---

**Remember**: The best way to learn is by doing. Don't be afraid to ask questions, and don't worry about making mistakes. We're all here to help each other grow! 🌱
