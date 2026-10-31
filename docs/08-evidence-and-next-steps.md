# 08 — Evidence, Results, and Next Steps

## Evidence captured in the hands-on session

The user-provided JFrog screenshots showed:

1. Xray Indexed Resources: `foma-docker-local` was Local / Docker and indexed 7 of 7 artifacts (100%).
2. Xray Scans List: artifact `secure-api/v1` was present; scan status was Done.
3. Artifact overview: 78 vulnerability findings — 0 Critical, 17 High, 28 Medium, 33 Low; 96 SBOM components; 0 malicious packages; 0 policy violations before the custom watch/policy was created.
4. Vulnerability list: the UI showed 8 findings including a fix version and a JFrog-enriched finding count of 13.
5. CVE-2025-8869 detail: affected component shown as `pip:25.0.1`, CVSS 5.90 v4, Low classification, impact path `secure-api → pip`.
6. The Xray **Remediation** tab showed that intelligent remediation guidance required an Advanced Security entitlement.
7. The **Public Sources** tab described the TAR extraction / symbolic-link handling issue and the relevance of Python PEP 706.

## Evidence still to capture

- [ ] Terminal output for Python and pip versions inside `secure-api:v1`.
- [ ] Trivy full scan report and filtered HIGH/CRITICAL report.
- [ ] JFrog repository path and successful push evidence (redact account data).
- [ ] Xray policy configuration screenshot.
- [ ] Xray watch resource scope and policy association.
- [ ] Watch Violations page after applying the watch to existing content.
- [ ] Verified pip fix version and upstream advisory source.
- [ ] `secure-api:v2` build output and app endpoint tests.
- [ ] Trivy and Xray scan results for `secure-api:v2`.
- [ ] Before/after comparison of vulnerability findings.
- [ ] Kubernetes rollout and policy verification, if the optional deployment lab is completed.

## Recruiter-facing project summary

Built a container security workflow around a Python API using Docker, Trivy, JFrog Artifactory, and JFrog Xray. Published a container image to a JFrog Docker local repository, configured repository indexing, inspected its SBOM and vulnerability findings, and investigated a pip-related CVE by examining the affected component, CVSS metadata, impact path, public advisory, and runtime mitigation context. The next engineering steps are to configure a severity-based Xray policy and watch, remediate verified findings, rebuild and rescan the image, and enforce the resulting security decision in CI/CD and Kubernetes admission.

## Current status

| Activity | Status |
|---|---|
| Build `secure-api:v1` | Completed in lab |
| Initial Trivy scan | Completed in lab |
| Push to JFrog local | Confirmed by user |
| Xray repository indexing | 7/7 (100%) observed |
| Xray scan | Done observed |
| Findings review | 78 findings observed |
| CVE-2025-8869 investigation | Initial review completed; version validation pending |
| Intelligent remediation feature | Locked in current plan |
| Custom Xray policy | Not yet evidenced as created |
| Custom Xray watch | Not yet evidenced as created |
| Rebuild as `secure-api:v2` | Pending |
| Before/after scan comparison | Pending |
| Kubernetes deployment enforcement | Design documented; not yet evidenced |

This status table is intentionally conservative: only actions supported by user confirmation or supplied screenshots are marked complete.
