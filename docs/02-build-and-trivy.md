# 02 — Build, Run, and Scan the Container

## Application

The sample service is a small Flask API with two endpoints:

- `GET /` — application metadata.
- `GET /health` — health status.

## Build

From the repository root:

```bash
docker build -t secure-api:v1 .
```

What happens:

1. Docker reads the Dockerfile.
2. The `python:3.12-slim` base image is selected.
3. Python dependencies are installed.
4. Application source is copied into `/app`.
5. An unprivileged user named `appuser` is configured.
6. The image's default command starts the API.

## Run and test

```bash
docker run -d --name secure-api -p 5000:5000 secure-api:v1
curl http://localhost:5000/
curl http://localhost:5000/health
docker logs secure-api
docker rm -f secure-api
```

## Verify the runtime identity

```bash
docker run --rm secure-api:v1 whoami
docker run --rm secure-api:v1 ls -ld /app
```

Expected identity: `appuser`. The `--rm` option removes the temporary container after it exits; it does not delete the image.

## Scan with Trivy

```bash
trivy image secure-api:v1
trivy image --severity HIGH,CRITICAL secure-api:v1
```

For a CI gate:

```bash
trivy image --severity HIGH,CRITICAL --exit-code 1 secure-api:v1
```

The last command returns a non-zero exit code when matching findings are present. This can fail a pipeline step. Choose severity thresholds based on your threat model, exploitability, exposure, and remediation SLA—not severity alone.

## Reports

Create a machine-readable report:

```bash
mkdir -p reports
trivy image --format json --output reports/trivy-v1.json secure-api:v1
```

Review reports before committing them. They can contain environment or package information; publish only what is appropriate.

## Interpretation

- A scan is a point-in-time result.
- HIGH/CRITICAL-only output does not imply the image is vulnerability-free.
- Trivy and Xray may report different totals because they use different intelligence sources and analysis approaches.
- Retain the image tag and scan timestamp so results can be compared accurately.
