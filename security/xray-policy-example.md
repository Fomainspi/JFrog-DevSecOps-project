# Example Xray Security Policy

This is a human-readable configuration plan, not an importable JFrog policy export. Create and validate the rule in the JFrog UI for the installed Xray version.

## Identity

- Name: `secure-api-production-security-policy`
- Type: Security
- Purpose: Flag high-risk component vulnerabilities in the application container.

## Suggested lab rule

| Condition | Suggested value |
|---|---|
| Vulnerability severity | High or Critical |
| Scope | Components in the watched container artifact |
| Action | Generate a policy violation; connect a CI/release gate separately |

## Governance

- Define severity-based remediation SLAs.
- Review exploitability and exposure.
- Require documented exceptions with owner and expiry.
- Retest after remediation.
- Never silently suppress findings because a package appears unused without validating the impact path.
- Revisit thresholds as the application risk changes.
