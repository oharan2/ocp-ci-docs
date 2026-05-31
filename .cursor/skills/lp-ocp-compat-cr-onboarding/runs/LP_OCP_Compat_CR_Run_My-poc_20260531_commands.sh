#!/usr/bin/env bash
# LP OCP Compat CR onboarding run: My-poc
# Documentation-only POC. No remotes pushed to origin per operator request.
# Commit message tag: [ocp-ci-docs] lp-ocp-compat-cr-onboarding

set -euo pipefail

# Invocation parameters
# lp-name=My-poc lp-slug=my-poc lp-repo=redhatqe/my-poc lp-branch=main
# lp-ver=lpGA ocp-release=4.22
# release-config=ci-operator/config/redhatqe/my-poc/redhatqe-my-poc-main__ocp-4.22-lpGA-lp-ocp-compat.yaml
# test-variant=aws gh-user=oharan2 make-maintainer=user

WORKDIR=$(mktemp -d -t cr-onboarding-XXXXXX)
echo "WORKDIR=${WORKDIR}"

cd "${WORKDIR}"

# Phase 0: clone upstream repos (local workspace only)
git clone https://github.com/openshift/release.git
git clone https://github.com/openshift/sippy.git
git clone https://github.com/openshift-eng/ci-test-mapping.git

for repo in release sippy ci-test-mapping; do
  cd "${WORKDIR}/${repo}"
  git remote rename origin upstream
  git remote add origin "https://github.com/oharan2/${repo}.git"
  git fetch upstream main
  git checkout main
  git reset --hard upstream/main
  git checkout -b my-poc
done

# --- openshift/release (mock edits documented in report) ---
# File: ci-operator/config/redhatqe/my-poc/redhatqe-my-poc-main__ocp-4.22-lpGA-lp-ocp-compat.yaml
# Maintainer hand-off (not run; make-maintainer=user): make jobs

# --- openshift/sippy (mock edits documented in report) ---
# Files: pkg/variantregistry/ocp.go, config/views.yaml
# Maintainer hand-off (not run): make update-variants
# Maintainer hand-off (not run): ./sippy variants snapshot --config ./config/openshift.yaml

# --- openshift-eng/ci-test-mapping (mock edits documented in report) ---
# Files: pkg/components/lpmypoc/component.go, capabilities.go, pkg/registry/registry.go
# Maintainer hand-off (not run): make mapping

# PR creation (NOT EXECUTED; no push to origin)
# gh pr create --repo openshift/release --head oharan2:my-poc --base main \
#   --title "Onboard My-poc for LP OCP Compat Component Readiness (release)"
# gh pr create --repo openshift/sippy --head oharan2:my-poc --base main \
#   --title "Onboard My-poc for LP OCP Compat Component Readiness (Sippy)"
# gh pr create --repo openshift-eng/ci-test-mapping --head oharan2:my-poc --base main \
#   --title "Onboard My-poc for LP OCP Compat Component Readiness (ci-test-mapping)"

echo "Run complete. See My-poc_CR_Onboarding_Report.md for mock PR content and links."
echo "Cleanup: rm -rf ${WORKDIR}"
