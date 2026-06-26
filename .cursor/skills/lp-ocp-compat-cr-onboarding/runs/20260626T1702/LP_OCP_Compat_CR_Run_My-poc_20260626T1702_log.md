# LP OCP Compat CR Onboarding Run Log — My-poc

| Field         | Value                         |
|---------------|-------------------------------|
| LP Name       | `My-poc`                      |
| Run ID        | `20260626T1702`               |
| Skill         | `lp-ocp-compat-cr-onboarding` |
| Invocation    | `[ocp-ci-docs] lp-ocp-compat-cr-onboarding` |
| Date          | 2026-06-26                    |
| Mode          | Mock / documentation-only POC |

---

## Invocation

```text
/lp-ocp-compat-cr-onboarding lp-name=My-poc lp-slug=my-poc lp-repo=myorg/my-poc lp-branch=main lp-ver=lpGA ocp-release=4.22 release-config=ci-operator/config/myorg/my-poc/myorg-my-poc-main__ocp-4.22-lpGA-lp-ocp-compat.yaml test-variant=aws cron="0 6,18 * * *" gh-user=GH_USERNAME make-maintainer=requester
```

---

## Identifier Table

| Identifier                                | Value                                                                                      |
|-------------------------------------------|--------------------------------------------------------------------------------------------|
| `DR__RP__CR_COMP_NAME` / TS prefix        | `lp-ocp-compat--My-poc`                                                                    |
| `.tests[].as`                             | `cr--my-poc--aws`                                                                          |
| Periodic CI Operator Job name             | `periodic-ci-myorg-my-poc-main-ocp-4.22-lpGA-lp-ocp-compat-cr--my-poc--aws`               |
| Sippy `layeredProductPatterns` sub-string | `-lpga-lp-ocp-compat-cr--my-poc--`                                                         |
| Sippy CR Variant `LayeredProduct`         | `lp-ocp-compat--my-poc--lpGA`                                                              |
| CR View (`view=`)                         | `4.22-LP-OCP-Compat--lpGA`                                                                 |
| ci-test-mapping Go package                | `lpmypoc`                                                                                  |
| Jira / CR Component                       | `LP--My-poc`                                                                               |
| `SuiteRegEx`                              | `` `^lp-ocp-compat--My-poc--` ``                                                           |
| Registry symbol                           | `LPmypocComponent`                                                                         |
| CI Operator config file                   | `ci-operator/config/myorg/my-poc/myorg-my-poc-main__ocp-4.22-lpGA-lp-ocp-compat.yaml`     |

---

## Pull Request Summary

> **Note:** No code was pushed to any remote in this run. The PR links below are mock placeholders for documentation purposes.

| # | Repo                                                                                   | Branch                      | Mock PR URL                                                                 | Status      |
|---|----------------------------------------------------------------------------------------|-----------------------------|-----------------------------------------------------------------------------|-------------|
| 1 | [openshift/release](https://github.com/openshift/release)                             | `cr-onboarding--my-poc`     | https://github.com/openshift/release/pull/MOCK-My-poc-001                  | Mock / Pending push |
| 2 | [openshift/sippy](https://github.com/openshift/sippy)                                 | `cr-onboarding--my-poc`     | https://github.com/openshift/sippy/pull/MOCK-My-poc-002                    | Mock / Pending push |
| 3 | [openshift-eng/ci-test-mapping](https://github.com/openshift-eng/ci-test-mapping)     | `cr-onboarding--my-poc`     | https://github.com/openshift-eng/ci-test-mapping/pull/MOCK-My-poc-003      | Mock / Pending push |

---

## PR 1: openshift/release (mock)

**File:** `ci-operator/config/myorg/my-poc/myorg-my-poc-main__ocp-4.22-lpGA-lp-ocp-compat.yaml`

```yaml
tests:
  - as: cr--my-poc--aws
    cron: 0 6,18 * * *
    steps:
      env:
        MAP_TESTS: "true"
        DR__RP__CR_COMP_NAME: lp-ocp-compat--My-poc
```

**Maintainer hand-off:** `make update` (not run in this POC; `make-maintainer=requester`).

**Verification:** After a CI Operator Job Run, JUnit XML under the CI Operator Test Step artifacts must show `<testsuite name="lp-ocp-compat--My-poc--...">`.

### PR 1 Body

```markdown
## Onboard My-poc for LP OCP Compat Component Readiness (openshift/release)

[ocp-ci-docs] lp-ocp-compat-cr-onboarding

### Identifier table

| Identifier                                | Value                                                                                  |
|-------------------------------------------|----------------------------------------------------------------------------------------|
| `DR__RP__CR_COMP_NAME` / TS prefix        | `lp-ocp-compat--My-poc`                                                                |
| `.tests[].as`                             | `cr--my-poc--aws`                                                                      |
| Periodic CI Operator Job name             | `periodic-ci-myorg-my-poc-main-ocp-4.22-lpGA-lp-ocp-compat-cr--my-poc--aws`           |
| Sippy `layeredProductPatterns` sub-string | `-lpga-lp-ocp-compat-cr--my-poc--`                                                     |
| Sippy CR Variant `LayeredProduct`         | `lp-ocp-compat--my-poc--lpGA`                                                          |
| CR View (`view=`)                         | `4.22-LP-OCP-Compat--lpGA`                                                             |
| ci-test-mapping Go package                | `lpmypoc`                                                                              |
| Jira / CR Component                       | `LP--My-poc`                                                                           |

### Cross-links
- openshift/sippy PR: https://github.com/openshift/sippy/pull/MOCK-My-poc-002
- openshift-eng/ci-test-mapping PR: https://github.com/openshift-eng/ci-test-mapping/pull/MOCK-My-poc-003

### Maintainer make lines (requester to run)
```bash
make update
```
```

---

## PR 2: openshift/sippy (mock)

**File:** `pkg/variantregistry/ocp.go` (inside `layeredProductPatterns` in `setLayeredProduct()`)

```go
{"-lpga-lp-ocp-compat-cr--my-poc--", "lp-ocp-compat--my-poc--lpGA"},
```

**File:** `config/views.yaml` (inside the `4.22-LP-OCP-Compat--lpGA` block, alphabetically sorted)

```yaml
    LayeredProduct:
      - lp-ocp-compat--my-poc--lpGA
```

**Files skipped (standard LP OCP Compat):**
- Step 1 (`BigQuery pattern`) — standard `lp-ocp-compat-%` pattern already covers this job.
- Step 2 (`setOwner`) — not required for LP OCP Compat.
- Step 6 (`testSuitePatterns`) — `lp-ocp-compat--%` already present in `pkg/db/suites.go`.

**Maintainer hand-off:** `make update-variants` then `./sippy variants snapshot --config ./config/openshift.yaml`; commit `pkg/variantregistry/snapshot.yaml`.

### PR 2 Body

```markdown
## Onboard My-poc for LP OCP Compat Component Readiness (Sippy)

[ocp-ci-docs] lp-ocp-compat-cr-onboarding

### Identifier table

| Identifier                                | Value                                                                                  |
|-------------------------------------------|----------------------------------------------------------------------------------------|
| `DR__RP__CR_COMP_NAME` / TS prefix        | `lp-ocp-compat--My-poc`                                                                |
| `.tests[].as`                             | `cr--my-poc--aws`                                                                      |
| Periodic CI Operator Job name             | `periodic-ci-myorg-my-poc-main-ocp-4.22-lpGA-lp-ocp-compat-cr--my-poc--aws`           |
| Sippy `layeredProductPatterns` sub-string | `-lpga-lp-ocp-compat-cr--my-poc--`                                                     |
| Sippy CR Variant `LayeredProduct`         | `lp-ocp-compat--my-poc--lpGA`                                                          |
| CR View (`view=`)                         | `4.22-LP-OCP-Compat--lpGA`                                                             |
| ci-test-mapping Go package                | `lpmypoc`                                                                              |
| Jira / CR Component                       | `LP--My-poc`                                                                           |

### Cross-links
- openshift/release PR: https://github.com/openshift/release/pull/MOCK-My-poc-001
- openshift-eng/ci-test-mapping PR: https://github.com/openshift-eng/ci-test-mapping/pull/MOCK-My-poc-003

### Maintainer make lines (requester to run)
```bash
make update-variants
./sippy variants snapshot --config ./config/openshift.yaml
# then commit pkg/variantregistry/snapshot.yaml
```
```

---

## PR 3: openshift-eng/ci-test-mapping (mock)

**File:** `pkg/components/lpmypoc/component.go`

```go
package lpmypoc

import (
	"regexp"

	v1 "github.com/openshift-eng/ci-test-mapping/pkg/api/types/v1"
	"github.com/openshift-eng/ci-test-mapping/pkg/config"
)

type Component struct {
	*config.Component
}

var LPmypocComponent = Component{
	Component: &config.Component{
		Name:                 "LP--My-poc",
		Operators:            []string{},
		DefaultJiraComponent: "LP--My-poc",
		Matchers: []config.ComponentMatcher{
			{SuiteRegEx: regexp.MustCompile(`^lp-ocp-compat--My-poc--`)},
		},
	},
}

func (c *Component) IdentifyTest(test *v1.TestInfo) (*v1.TestOwnership, error) {
	if matcher := c.FindMatch(test); matcher != nil {
		jira := matcher.JiraComponent
		if jira == "" {
			jira = c.DefaultJiraComponent
		}
		return &v1.TestOwnership{
			Name:          test.Name,
			Component:     c.Name,
			JIRAComponent: jira,
			Priority:      matcher.Priority,
			Capabilities:  append(matcher.Capabilities, identifyCapabilities(test)...),
		}, nil
	}
	return nil, nil
}

func (c *Component) StableID(test *v1.TestInfo) string {
	if stableName, ok := c.TestRenames[test.Name]; ok {
		return stableName
	}
	return test.Name
}

func (c *Component) JiraComponents() (components []string) {
	components = []string{c.DefaultJiraComponent}
	for _, m := range c.Matchers {
		components = append(components, m.JiraComponent)
	}
	return components
}
```

**File:** `pkg/components/lpmypoc/capabilities.go`

```go
package lpmypoc

import (
	v1 "github.com/openshift-eng/ci-test-mapping/pkg/api/types/v1"
	"github.com/openshift-eng/ci-test-mapping/pkg/util"
)

func identifyCapabilities(test *v1.TestInfo) []string {
	capabilities := util.DefaultCapabilities(test)
	return capabilities
}
```

**File:** `pkg/registry/registry.go` (add import and registration in `NewComponentRegistry()`)

```go
	"github.com/openshift-eng/ci-test-mapping/pkg/components/lpmypoc"
```

```go
	r.Register("LP--My-poc", &lpmypoc.LPmypocComponent)
```

**File skipped:** `config/openshift-eng.yaml` (`lp-ocp-compat--%` already covers TS names).

**Maintainer hand-off:** `make mapping`; commit regenerated `mapping.json`.

### PR 3 Body

```markdown
## Onboard My-poc for LP OCP Compat Component Readiness (ci-test-mapping)

[ocp-ci-docs] lp-ocp-compat-cr-onboarding

### Identifier table

| Identifier                                | Value                                                                                  |
|-------------------------------------------|----------------------------------------------------------------------------------------|
| `DR__RP__CR_COMP_NAME` / TS prefix        | `lp-ocp-compat--My-poc`                                                                |
| `.tests[].as`                             | `cr--my-poc--aws`                                                                      |
| Periodic CI Operator Job name             | `periodic-ci-myorg-my-poc-main-ocp-4.22-lpGA-lp-ocp-compat-cr--my-poc--aws`           |
| Sippy `layeredProductPatterns` sub-string | `-lpga-lp-ocp-compat-cr--my-poc--`                                                     |
| Sippy CR Variant `LayeredProduct`         | `lp-ocp-compat--my-poc--lpGA`                                                          |
| CR View (`view=`)                         | `4.22-LP-OCP-Compat--lpGA`                                                             |
| ci-test-mapping Go package                | `lpmypoc`                                                                              |
| Jira / CR Component                       | `LP--My-poc`                                                                           |

### Cross-links
- openshift/release PR: https://github.com/openshift/release/pull/MOCK-My-poc-001
- openshift/sippy PR: https://github.com/openshift/sippy/pull/MOCK-My-poc-002

### Maintainer make lines (requester to run)
```bash
make mapping
# then commit mapping.json
```
```

---

## Phase 0 Workspace (documented, not executed)

> No git operations were performed. The following documents what would be executed.

```bash
#!/bin/bash
set -euxo pipefail; shopt -s inherit_errexit

typeset workDir
workDir="$(mktemp -d -t cr-onboarding-XXXXXX)"
typeset -A rmtURLs=(
    ["openshift/release"]="https://github.com/GH_USERNAME/release.git"
    ["openshift/sippy"]="https://github.com/GH_USERNAME/sippy.git"
    ["openshift-eng/ci-test-mapping"]="https://github.com/GH_USERNAME/ci-test-mapping.git"
)

pushd "${workDir}"
typeset upRmt mainBranch
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
    # NOT RUN: git push --force-with-lease origin HEAD
    git switch -C cr-onboarding--my-poc
    popd
done
popd
true
```

---

## Maintainer Hand-off Checklist

| Repo                            | Command                                                                 | Owner      | Status  |
|---------------------------------|-------------------------------------------------------------------------|------------|---------|
| `openshift/release`             | `make update`                                                           | requester  | Pending |
| `openshift/sippy`               | `make update-variants` + `./sippy variants snapshot --config ./config/openshift.yaml` | requester | Pending |
| `openshift-eng/ci-test-mapping` | `make mapping`                                                          | requester  | Pending |

---

## Verification Checklist

- [ ] JUnit XML `<testsuite name="lp-ocp-compat--My-poc--...">` confirmed in Prow Job Artifacts after first run.
- [ ] `periodic-ci-myorg-my-poc-main-ocp-4.22-lpGA-lp-ocp-compat-cr--my-poc--aws` appears in [CR 4.22-LP-OCP-Compat--lpGA](https://sippy.dptools.openshift.org/sippy-ng/component_readiness/main?view=4.22-LP-OCP-Compat--lpGA).
- [ ] `LP--My-poc` component visible in CR after ci-test-mapping `mapping.json` regenerated and PR merged.

---

## References

- [Worked Example: MPEXOperator](../references/worked-example-mpexoperator.md)
- [Reporting Guide, Component Readiness](../../../../docs/OCP_CI_Tutorials/Reporting/Reporting_Guide.md#component-readiness)
- [Reporting Guide, Onboarding Inputs](../../../../docs/OCP_CI_Tutorials/Reporting/Reporting_Guide.md#onboarding-inputs)
- [openshift/release](https://github.com/openshift/release)
- [openshift/sippy](https://github.com/openshift/sippy)
- [openshift-eng/ci-test-mapping](https://github.com/openshift-eng/ci-test-mapping)
