#!/usr/bin/env bash
# Deploy the site to S3 and invalidate CloudFront. Needs the AWS CLI with access to account 135379837669.
set -euo pipefail
cd "$(dirname "$0")"

BUCKET="botique.workingalien.com"
DIST_ID="E29F8UJLC7S3R6"   # filled in by the one-time setup

EXCLUDES=(--exclude ".git/*" --exclude ".gitignore" --exclude ".claude/*" --exclude ".DS_Store" --exclude "deploy.sh" --exclude "README.md" --exclude "*.log")

# Fonts and images: cache for a year. Everything else: 5 minutes, so edits show up quickly.
aws s3 sync . "s3://$BUCKET" --delete "${EXCLUDES[@]}" \
  --exclude "*" --include "assets/*" --cache-control "public, max-age=31536000, immutable"
aws s3 sync . "s3://$BUCKET" --delete "${EXCLUDES[@]}" \
  --exclude "assets/*" --cache-control "public, max-age=300"

aws cloudfront create-invalidation --distribution-id "$DIST_ID" --paths "/*" --query "Invalidation.Id" --output text
echo "Deployed to https://$BUCKET/"
