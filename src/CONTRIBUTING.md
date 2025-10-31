# Contributing to OpenStrata.DevOps

Thank you for your interest in contributing to OpenStrata.DevOps! We welcome contributions from the community and are excited to collaborate with you.

## 🎯 How to Contribute

### Reporting Issues

Before creating an issue, please:

1. **Search existing issues** to avoid duplicates
2. **Use the issue templates** when available
3. **Provide detailed information** including:
   - Operating system and version
   - .NET version
   - Steps to reproduce the issue
   - Expected vs actual behavior
   - Relevant code samples or error messages

### Suggesting Features

We welcome feature suggestions! Please:

1. **Check existing feature requests** first
2. **Open a discussion** before submitting a large feature request
3. **Explain the use case** and why the feature would be valuable
4. **Consider the scope** - smaller, focused features are easier to implement

### Submitting Code Changes

1. **Fork the repository** and create a feature branch
2. **Follow coding standards** (see below)
3. **Write tests** for new functionality
4. **Update documentation** as needed
5. **Submit a pull request** with a clear description

## 🛠️ Development Setup

### Prerequisites

- [.NET SDK 8.0+](https://dotnet.microsoft.com/download)
- [PowerShell 7.0+](https://docs.microsoft.com/powershell/)
- [Git 2.30+](https://git-scm.com/)
- [Visual Studio Code](https://code.visualstudio.com/) (recommended)

### Local Development

1. **Clone your fork**
   ```powershell
   git clone https://github.com/YOUR-USERNAME/OpenStrata.DevOps.git
   cd OpenStrata.DevOps
   ```

2. **Install dependencies**
   ```powershell
   dotnet restore src/
   ```

3. **Build the solution**
   ```powershell
   dotnet build src/
   ```

4. **Run tests**
   ```powershell
   dotnet test src/
   ```

5. **Create a feature branch**
   ```powershell
   git checkout -b feature/your-feature-name
   ```

## 📝 Coding Standards

### General Guidelines

- **Follow .NET conventions** and use consistent naming
- **Write clear, self-documenting code**
- **Add XML documentation** for public APIs
- **Keep methods focused** and functions small
- **Use meaningful variable names**

### MSBuild Tasks

- **Inherit from BaseTask** when creating new MSBuild tasks
- **Implement proper error handling** using the TaskFailed methods
- **Add comprehensive logging** for debugging
- **Follow the established patterns** in existing tasks

### PowerShell Scripts

- **Use approved verbs** for function names
- **Add comment-based help** for all functions
- **Follow PowerShell best practices**
- **Test scripts on multiple platforms** when possible

### Documentation

- **Update README.md** when adding new features
- **Include code examples** in documentation
- **Use clear, concise language**
- **Update API documentation** for changes

## 🧪 Testing Guidelines

### Unit Tests

- **Write tests for all new functionality**
- **Maintain or improve code coverage**
- **Use descriptive test names** that explain the scenario
- **Follow the Arrange-Act-Assert pattern**

### Integration Tests

- **Test MSBuild task integration** where applicable
- **Verify PowerShell script functionality**
- **Test cross-platform compatibility** when possible

### Manual Testing

- **Test on multiple operating systems** when possible
- **Verify with different .NET versions**
- **Test both development and CI scenarios**

## 📋 Pull Request Process

1. **Ensure all tests pass** locally
2. **Update documentation** as needed
3. **Add or update tests** for your changes
4. **Follow conventional commit format** for commit messages
5. **Submit pull request** with clear description
6. **Address review feedback** promptly
7. **Keep your branch up to date** with main

### Pull Request Template

When submitting a PR, please include:

- **Description** of changes made
- **Related issues** (fixes #123)
- **Testing performed** and results
- **Breaking changes** (if any)
- **Documentation updates** included

## 🏷️ Commit Message Guidelines

We follow [Conventional Commits](https://www.conventionalcommits.org/):

```
type(scope): description

[optional body]

[optional footer]
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

```
feat(azure-pipelines): add support for multi-stage deployments

fix(power-platform): resolve authentication timeout issue

docs(readme): update installation instructions

test(msbuild-tasks): add unit tests for LoadStageIdeDevopsConfig
```

## 🌍 Community Guidelines

### Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you agree to uphold this code.

### Communication

- **Be respectful** and constructive in discussions
- **Help others** learn and grow
- **Share knowledge** and best practices
- **Ask questions** when you need clarification

### Getting Help

- **GitHub Discussions** for general questions and ideas
- **GitHub Issues** for bugs and feature requests
- **Pull Request reviews** for code-specific feedback

## 🎖️ Recognition

Contributors will be recognized in:

- **README.md** acknowledgments section
- **Release notes** for significant contributions
- **GitHub contributors** page

## 📄 License

By contributing to OpenStrata.DevOps, you agree that your contributions will be licensed under the [Apple Public Source License 2.0](LICENSE).

## 🙏 Thank You

Thank you for contributing to OpenStrata.DevOps! Your efforts help make this project better for everyone in the Microsoft Power Platform community.

---

*For questions about contributing, please open a [GitHub Discussion](https://github.com/Open-Strata/OpenStrata.DevOps/discussions) or contact the maintainers.*