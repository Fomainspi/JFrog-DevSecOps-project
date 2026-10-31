# 01 — Prepare the Environment

## Objectives

Prepare the tools needed to build, inspect, scan, and publish a container image.

## Tooling

| Tool | Why it is used | Verification |
|---|---|---|
| Git | Source control | `git --version` |
| Docker | Build and run the image | `docker version` |
| Trivy | Local image vulnerability scan | `trivy --version` |
| JFrog Platform | Artifact management and Xray analysis | Sign in to your JFrog instance |
| kubectl (optional for later lab) | Kubernetes operations | `kubectl version --client` |

Install tools using the official instructions for your operating system. Do not copy installation commands from an untrusted source.

## Create a workspace

```bash
mkdir -p ~/2026-projects/jfrog-project
cd ~/2026-projects/jfrog-project
```

Clone this repository when it has been published:

```bash
git clone https://github.com/Fomainspi/jfrog.git
cd jfrog
```

## Docker access

Check that Docker is running:

```bash
docker version
docker info
```

On Linux, avoid routinely running application containers with elevated privileges. Configure Docker access according to your workstation's security policy.

## Trivy

Check the CLI:

```bash
trivy --version
```

Trivy can scan a local image without publishing it:

```bash
trivy image secure-api:v1
```

## JFrog preparation

1. Sign in to your JFrog Platform.
2. Confirm that Artifactory and Xray are available to your account.
3. In Artifactory, identify a Docker **local** repository. This project used `foma-docker-local`.
4. Find the correct Docker registry hostname and login instructions in your JFrog instance's **Set Me Up** instructions.
5. In Xray Settings → Indexed Resources, confirm the Docker local repository is indexed.

Never assume the registry hostname from an example. Your JFrog domain, region, and access method determine it.

## Credentials

Use a JFrog access token or another approved credential. Authenticate interactively:

```bash
docker login YOUR_JFROG_DOCKER_REGISTRY
```

Do not put the token in source code, a shell command recorded in shared terminal history, screenshots, or this repository. Use a secret manager or environment-protected input where possible.

## Completion checklist

- [ ] Docker works.
- [ ] Trivy is installed.
- [ ] JFrog Artifactory is reachable.
- [ ] A Docker local repository has been selected.
- [ ] Registry hostname and authentication instructions have been identified.
- [ ] Xray is available and the target repository is indexed.
