# 04 — Configure Xray Indexing and Inspect Findings

## Enable repository indexing

In the observed JFrog interface:

1. Open **Administration → Xray Settings → Indexed Resources**.
2. Select the **Repositories** tab.
3. Confirm `foma-docker-local` is present.
4. Confirm the index status is complete.
5. If a previously uploaded artifact is not included, use the available **Index Existing** / re-index action as appropriate for your JFrog version.

## Observed lab evidence

The captured Indexed Resources screen showed:

| Repository | Type | Package type | Indexed artifacts |
|---|---|---|---:|
| `foma-docker-local` | Local | Docker | 7 / 7 (100%) |
| `foma-maven-local` | Local | Maven | 9 / 9 (100%) |

The Xray Scans List showed `secure-api/v1`, with repository path ending in `/secure-api/v1/manifest.json`, and scan status **Done**.

## Captured vulnerability results

The captured artifact overview reported:

| Metric | Observed value |
|---|---:|
| Total vulnerability findings | 78 |
| Critical | 0 |
| High | 17 |
| Medium | 28 |
| Low | 33 |
| Unknown | 0 |
| Malicious packages | 0 |
| Policy violations | 0 (before creating the custom policy/watch in this exercise) |
| SBOM components | 96 |

The High findings view also displayed 17 Critical & High vulnerabilities, 8 findings marked as including a fix version, and 13 findings enriched by JFrog. The top component card showed 22 findings associated with `debian:trixie:libc-bin 2.41-12+deb13u4`.

These are **captured point-in-time observations** from the user's JFrog instance. They may change with a new image build, updated Xray vulnerability intelligence, or rescanning.

## Interpret the numbers carefully

- Vulnerability findings are not necessarily unique packages.
- SBOM component count is not a vulnerability count.
- Zero policy violations does not mean zero vulnerabilities. It means no configured policy rule was violated in that scan context.
- “Malicious packages: Not Found” is not a guarantee that software is benign in every respect.
- A completed scan confirms scan execution, not security approval.

## Inspect a finding

In the artifact detail page, open **Security Issues → Vulnerabilities**. Review:

- Severity and CVSS score/version
- CVE identifier
- Affected component and installed version
- Fix Version, if provided
- CWE classification
- Impact path through the dependency graph
- Public sources and references

Do not upgrade based only on a displayed score. Confirm the affected component, vulnerable version range, applicable execution path, and remediation guidance.
