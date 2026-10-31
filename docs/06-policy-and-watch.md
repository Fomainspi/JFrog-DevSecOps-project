# 06 — Create an Xray Security Policy and Watch

## Concepts

- **Security policy:** defines the conditions that should trigger a security violation (for example, a severity threshold).
- **Watch:** defines the resources in scope and associates one or more policies with them.
- **Violation:** a result created when a scanned resource in the watch scope matches an attached policy condition.

A watch and policy provide evaluation and visibility. Blocking a CI pipeline, preventing an artifact promotion, or denying a Kubernetes deployment requires a configured enforcement integration or gate.

## Suggested lab policy

Create a policy named:

`secure-api-production-security-policy`

Suggested lab rule:

- Policy type: Security
- Trigger: vulnerability severity
- Threshold: High and Critical
- Scope: all relevant components in the scanned image

This is an illustrative learning threshold. Production thresholds must reflect the organization's risk appetite, exploitability, exposure, exception process, and remediation SLAs. A stricter policy may be appropriate for internet-facing production services.

## Suggested watch

Create a watch named:

`secure-api-security-watch`

Configure it to:

1. Include the `foma-docker-local` repository (or the narrowest available resource selector for the app).
2. Attach `secure-api-production-security-policy`.
3. Apply the watch to existing content if the UI offers an **Apply on Existing Content** action.
4. Save and verify the watch scope and policy association.

## UI navigation (labels can vary by JFrog version)

1. Open **Xray → Watches & Policies**.
2. Create the Security Policy and add a severity rule.
3. Save the policy.
4. Create a new Watch.
5. Add the Docker local repository as a resource.
6. Attach the policy.
7. Apply to existing content, if available.
8. Open **Xray → Watch Violations** and inspect violations for `secure-api/v1`.

## Expected lab observation

Before creating the custom policy/watch, the captured artifact overview showed **0 policy violations** despite 78 vulnerability findings. After the watch is configured and applied, evaluate whether the 17 High findings match the policy and appear as violations.

Do not assume the violation count until the UI confirms it. If no violations appear, verify the watch resource scope, policy attachment, existing-content application, and scan status.

## Enforcement options

To make policy results actionable:

- Integrate JFrog CLI/Xray scanning in CI and fail the pipeline on the configured violation result.
- Require approval before promoting an artifact to a release repository.
- Use immutable image digests in deployment manifests.
- Use a Kubernetes admission controller (such as Kyverno) for signature verification and deployment policy where appropriate.

**Do not say that a JFrog watch automatically blocks Docker push or Kubernetes deployment unless the corresponding enforcement integration has actually been configured and tested.**
