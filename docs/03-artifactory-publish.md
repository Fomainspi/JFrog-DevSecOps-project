# 03 — Publish the Image to JFrog Artifactory

## Repository design

The hands-on environment used a Docker local repository named:

`foma-docker-local`

A local repository stores artifacts published by your team. A remote repository proxies or caches an upstream registry. A virtual repository provides an aggregated endpoint over selected local and remote repositories.

## Obtain the registry endpoint

In JFrog, open the repository's Docker connection instructions / **Set Me Up** and copy the exact registry hostname and image naming pattern. Do not use a guessed hostname.

Set a shell variable using the value supplied by your instance:

```bash
export JFROG_REGISTRY="YOUR_JFROG_DOCKER_REGISTRY"
```

The variable should contain only the registry host (and port if shown), not a repository path.

## Authenticate

```bash
docker login "$JFROG_REGISTRY"
```

Enter credentials securely when prompted. Prefer an access token with least-privilege permissions.

## Tag and push

For the repository path used in the lab:

```bash
docker tag secure-api:v1 "$JFROG_REGISTRY/foma-docker-local/secure-api:v1"
docker push "$JFROG_REGISTRY/foma-docker-local/secure-api:v1"
```

The exact path format must follow the Docker repository instructions from your JFrog instance. Some instances use a repository-specific subdomain or other access pattern.

## Verify

In Artifactory, browse the Docker local repository and locate:

`secure-api/v1/manifest.json`

The hands-on session confirmed this artifact was present and subsequently visible in Xray.

## Important distinction

Pushing an image to Artifactory is artifact publication, not security approval. The next step is to ensure Xray has indexed the repository and to inspect the scan findings.

## Credentials hygiene

- Never commit tokens or passwords.
- Do not use `docker login -p TOKEN` in scripts.
- Use CI secret storage for automation.
- Use least-privilege repository permissions and rotate credentials according to policy.
