# Security Policy

## Supported Versions

We actively support the following versions of OpenStrata.DevOps with security updates:

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

The OpenStrata team takes security vulnerabilities seriously. We appreciate your efforts to responsibly disclose your findings.

### How to Report

**Do NOT report security vulnerabilities through public GitHub issues.**

Instead, please report security vulnerabilities by emailing: **security@openstrata.org**

Include the following information in your report:

- Type of issue (e.g. buffer overflow, SQL injection, cross-site scripting, etc.)
- Full paths of source file(s) related to the manifestation of the issue
- The location of the affected source code (tag/branch/commit or direct URL)
- Any special configuration required to reproduce the issue
- Step-by-step instructions to reproduce the issue
- Proof-of-concept or exploit code (if possible)
- Impact of the issue, including how an attacker might exploit it

### What to Expect

- **Acknowledgment**: We'll acknowledge receipt of your vulnerability report within 48 hours
- **Updates**: We'll provide regular updates on our progress
- **Timeline**: We aim to resolve critical vulnerabilities within 90 days
- **Credit**: We'll credit you in our security advisories (unless you prefer to remain anonymous)

### Security Update Process

1. **Triage**: We assess the vulnerability and determine severity
2. **Fix**: We develop and test a fix
3. **Release**: We release a security update
4. **Advisory**: We publish a security advisory
5. **Communication**: We notify users through appropriate channels

## Security Best Practices

When using OpenStrata.DevOps, please follow these security best practices:

### Environment Variables and Secrets

- **Never commit secrets** to version control
- **Use environment variables** for sensitive configuration
- **Rotate secrets regularly** in production environments
- **Use Azure Key Vault** or similar services for secret management

### MSBuild Security

- **Validate inputs** in custom MSBuild tasks
- **Sanitize file paths** to prevent directory traversal
- **Use least privilege** when running build processes
- **Monitor build outputs** for sensitive information

### CI/CD Security

- **Secure your pipelines** with appropriate permissions
- **Use service principals** with minimal required permissions
- **Enable branch protection** rules
- **Audit pipeline logs** regularly

### Power Platform Security

- **Follow Power Platform security guidelines**
- **Use service principals** for automated deployments
- **Implement proper authentication** flows
- **Monitor solution deployments**

## Dependencies

We regularly monitor our dependencies for security vulnerabilities:

- **Automated scanning** with Dependabot
- **Regular updates** to latest secure versions
- **Security advisories** for known vulnerabilities

## Contact

For general security questions or concerns:
- **Email**: security@openstrata.org
- **GitHub Discussions**: [Security Category](https://github.com/Open-Strata/OpenStrata.DevOps/discussions/categories/security)

---

Thank you for helping keep OpenStrata.DevOps and our community safe!