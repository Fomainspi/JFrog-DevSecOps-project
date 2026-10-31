# Example Xray Watch

This is a setup guide, not an importable JFrog watch export.

## Identity

- Name: `secure-api-security-watch`
- Resource: `foma-docker-local` or the narrowest supported selector for `secure-api`
- Attached policy: `secure-api-production-security-policy`

## Verification

After saving:

1. Verify the resource is included.
2. Verify the intended policy is attached.
3. Apply to existing content if required by the UI.
4. Open Watch Violations.
5. Confirm the `secure-api/v1` artifact is evaluated.
6. Record the result and timestamp.

A watch scopes policy evaluation. It does not independently guarantee that image push or deployment is blocked.
