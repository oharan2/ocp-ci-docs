#!/bin/bash
# LP OCP Compat CR Onboarding — My-poc
# Run ID: 20260626T1702
# Skill: [ocp-ci-docs] lp-ocp-compat-cr-onboarding
# Mode: MOCK / documentation-only — no commands were executed against any remote.
# To execute for real: remove the DRY_RUN guard and supply actual gh-user fork URLs.

set -euxo pipefail
shopt -s inherit_errexit

# ── Parameters ────────────────────────────────────────────────────────────────
LP_NAME="My-poc"
LP_SLUG="my-poc"
LP_REPO="myorg/my-poc"
LP_BRANCH="main"
LP_VER="lpGA"
OCP_RELEASE="4.22"
RELEASE_CONFIG="ci-operator/config/myorg/my-poc/myorg-my-poc-main__ocp-4.22-lpGA-lp-ocp-compat.yaml"
TEST_VARIANT="aws"
CRON="0 6,18 * * *"
GH_USER="GH_USERNAME"
MAKE_MAINTAINER="requester"
JIRA_COMPONENT="LP--My-poc"
FEATURE_BRANCH="cr-onboarding--${LP_SLUG}"

# ── Phase 0: workspace setup ──────────────────────────────────────────────────
# (NOT executed in mock run)

workDir="$(mktemp -d -t cr-onboarding-XXXXXX)"

declare -A rmtURLs=(
    ["openshift/release"]="https://github.com/${GH_USER}/release.git"
    ["openshift/sippy"]="https://github.com/${GH_USER}/sippy.git"
    ["openshift-eng/ci-test-mapping"]="https://github.com/${GH_USER}/ci-test-mapping.git"
)

pushd "${workDir}"
for upRmt in "${!rmtURLs[@]}"; do
    [ -d "${upRmt#*/}" ] || git clone --depth=1 --single-branch --no-tags "${rmtURLs[${upRmt}]}"
    pushd "${upRmt#*/}"
    git remote get-url upstream &>/dev/null || git remote add upstream "https://github.com/${upRmt}.git"
    git remote set-url --push upstream noPush
    mainBranch="$(git rev-parse --abbrev-ref upstream/HEAD | sed 's|^upstream/||')"
    git switch "${mainBranch}"
    git fetch --depth=1 --no-tags -pP origin HEAD
    git fetch --depth=1 --no-tags -pP upstream HEAD
    git reset --hard upstream/HEAD
    # MOCK: git push --force-with-lease origin HEAD
    git switch -C "${FEATURE_BRANCH}"
    popd
done
popd

# ── PR 1: openshift/release ───────────────────────────────────────────────────
# File: ci-operator/config/myorg/my-poc/myorg-my-poc-main__ocp-4.22-lpGA-lp-ocp-compat.yaml
# Add .tests[].as = cr--my-poc--aws with MAP_TESTS and DR__RP__CR_COMP_NAME env vars.
# Commit message: "Onboard My-poc for LP OCP Compat CR [ocp-ci-docs] lp-ocp-compat-cr-onboarding"
#
# MOCK: git -C "${workDir}/release" add "${RELEASE_CONFIG}"
# MOCK: git -C "${workDir}/release" commit -m "Onboard My-poc for LP OCP Compat CR [ocp-ci-docs] lp-ocp-compat-cr-onboarding"
# MOCK: git -C "${workDir}/release" push origin "${FEATURE_BRANCH}"
# MOCK: gh pr create --repo openshift/release \
#         --head "${GH_USER}:${FEATURE_BRANCH}" --base main \
#         --title "Onboard My-poc for LP OCP Compat Component Readiness (openshift/release)"

# ── PR 2: openshift/sippy ─────────────────────────────────────────────────────
# File: pkg/variantregistry/ocp.go — add to layeredProductPatterns:
#   {"-lpga-lp-ocp-compat-cr--my-poc--", "lp-ocp-compat--my-poc--lpGA"},
#
# File: config/views.yaml — add under 4.22-LP-OCP-Compat--lpGA > LayeredProduct:
#   - lp-ocp-compat--my-poc--lpGA
#
# Maintainer (requester): make update-variants && ./sippy variants snapshot --config ./config/openshift.yaml
#
# MOCK: git -C "${workDir}/sippy" add pkg/variantregistry/ocp.go config/views.yaml
# MOCK: git -C "${workDir}/sippy" commit -m "Onboard My-poc for LP OCP Compat CR [ocp-ci-docs] lp-ocp-compat-cr-onboarding"
# MOCK: git -C "${workDir}/sippy" push origin "${FEATURE_BRANCH}"
# MOCK: gh pr create --repo openshift/sippy \
#         --head "${GH_USER}:${FEATURE_BRANCH}" --base main \
#         --title "Onboard My-poc for LP OCP Compat Component Readiness (Sippy)"

# ── PR 3: openshift-eng/ci-test-mapping ──────────────────────────────────────
# New files:
#   pkg/components/lpmypoc/component.go
#   pkg/components/lpmypoc/capabilities.go
# Modified:
#   pkg/registry/registry.go — add import + r.Register("LP--My-poc", &lpmypoc.LPmypocComponent)
#
# Maintainer (requester): make mapping
#
# MOCK: git -C "${workDir}/ci-test-mapping" add \
#         pkg/components/lpmypoc/component.go \
#         pkg/components/lpmypoc/capabilities.go \
#         pkg/registry/registry.go
# MOCK: git -C "${workDir}/ci-test-mapping" commit -m "Onboard My-poc for LP OCP Compat CR [ocp-ci-docs] lp-ocp-compat-cr-onboarding"
# MOCK: git -C "${workDir}/ci-test-mapping" push origin "${FEATURE_BRANCH}"
# MOCK: gh pr create --repo openshift-eng/ci-test-mapping \
#         --head "${GH_USER}:${FEATURE_BRANCH}" --base main \
#         --title "Onboard My-poc for LP OCP Compat Component Readiness (ci-test-mapping)"

# ── Cross-link PR bodies ──────────────────────────────────────────────────────
# After all three PRs are open, back-update each body with the full set of cross-links:
# MOCK: gh pr edit <PR1_NUMBER> --repo openshift/release          --body-file /path/to/pr1_body.md
# MOCK: gh pr edit <PR2_NUMBER> --repo openshift/sippy            --body-file /path/to/pr2_body.md
# MOCK: gh pr edit <PR3_NUMBER> --repo openshift-eng/ci-test-mapping --body-file /path/to/pr3_body.md

# ── Cleanup ───────────────────────────────────────────────────────────────────
# MOCK: rm -rf "${workDir}"
