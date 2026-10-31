#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="${IMAGE_NAME:-secure-api}"
IMAGE_TAG="${IMAGE_TAG:-v1}"
IMAGE="${IMAGE_NAME}:${IMAGE_TAG}"

docker build --pull -t "$IMAGE" .
docker image inspect "$IMAGE" >/dev/null

if command -v trivy >/dev/null 2>&1; then
  mkdir -p reports
  trivy image --severity HIGH,CRITICAL "$IMAGE"
  trivy image --format json --output "reports/trivy-${IMAGE_TAG}.json" "$IMAGE"
else
  echo "Trivy is not installed; image build completed without a scan." >&2
  exit 2
fi

echo "Built and scanned: $IMAGE"
