# DevOps / DevSecOps Technical Interview Preparation Handbook

**Prepared by:** William Foma  
**Target role:** DevOps / DevSecOps Engineer — Singapore, onsite, 12-month renewable contract  
**Focus:** JFrog Artifactory, Xray, Curation, Nexus, Jenkins, GitHub Actions, software supply-chain security, Linux, AWS, Azure, Terraform, CloudFormation, Docker, Kubernetes, EKS and Helm.

> Use these answers as frameworks, not scripts to memorize. Distinguish clearly between professional experience, personal lab work and concepts you have studied. Never claim hands-on experience you cannot demonstrate.

## Contents

1. Role overview and interview format
2. Opening introduction
3. JFrog Artifactory, Xray, Curation and Nexus
4. Software supply-chain security
5. Jenkins and GitHub Actions
6. AWS, Azure and Infrastructure as Code
7. Docker, Kubernetes, EKS and Helm
8. Linux, networking and Bash
9. Programming and automation
10. Production troubleshooting scenarios
11. Architecture and senior-level questions
12. Behavioral and HR questions
13. Questions to ask the interviewer
14. Practical exercises
15. Seven-day preparation plan
16. Mock interview question bank
17. Official resources
18. Your JFrog DevSecOps project

---

## 1. Role overview and interview format

This position combines DevOps platform operations, CI/CD engineering, artifact management, open-source governance and secure software delivery. Its most distinctive requirements are JFrog, Nexus and software supply-chain security.

| Area | Technologies and concepts |
|---|---|
| Artifact management | JFrog Artifactory, Nexus Repository, local/remote/virtual repositories |
| Artifact security | JFrog Xray, Curation, vulnerability policies, SBOM, signing |
| CI/CD | GitHub Actions, Jenkins, runners, agents, reusable workflows |
| Cloud | AWS, Azure, EKS, IAM, networking, storage |
| Infrastructure as Code | Terraform, CloudFormation, state, modules, drift |
| Containers | Docker, image hardening, registries, immutable digests |
| Orchestration | Kubernetes, Helm, deployments, RBAC, admission controls |
| Operations | Linux, Bash, networking, logs, metrics, incident response |
| Development | JavaScript, Java, Python or .NET |

### How a technical interview may be conducted

The employer's exact process is not known. A role like this may include:

1. **Technical screening:** Experience, architecture, tools and responsibilities.
2. **Technical deep dive:** JFrog, Nexus, CI/CD, security governance and cloud infrastructure.
3. **Practical exercise:** Review or write YAML, Bash or Terraform; troubleshoot a pipeline or Kubernetes issue.
4. **Architecture discussion:** Design a secure platform supporting multiple engineering teams.
5. **Behavioral discussion:** Collaboration, incidents, ownership and communication.

Possible formats include verbal questions, screen sharing, timed exercises and architecture discussions. You may not need to build a complete application. Be ready to explain your reasoning and show how you would validate a solution.

### A reliable answer structure

1. Clarify the requirement and impact.
2. Explain the architecture or relevant components.
3. Describe implementation steps.
4. Explain security and operational controls.
5. Explain how you would validate success.
6. Mention rollback, monitoring and documentation where relevant.

---

## 2. Opening introduction

### Q1. Tell me about yourself.

**Suggested answer — personalize it to your actual work:**

"I'm a DevOps and DevSecOps engineer focused on cloud infrastructure, CI/CD automation, containerization, infrastructure as code and secure software delivery.

My professional experience includes working in enterprise environments and collaborating across technical and operational teams. My background includes organizations such as WTW, IBM and Nestlé, where I developed an appreciation for reliability, process improvement and disciplined operations.

My technical focus includes Linux, AWS, Docker, Kubernetes, Terraform, Jenkins, GitHub Actions and monitoring. I have also been developing practical experience in artifact management and software supply-chain security through hands-on work with JFrog Artifactory, Xray and container scanning.

A recent practical project demonstrates a workflow for building and hardening a container, scanning it with Trivy, publishing it to JFrog Artifactory, analyzing indexed components with Xray and documenting Kubernetes deployment controls.

This opportunity interests me because it combines platform engineering with open-source governance and secure software delivery. I want to help engineering teams deliver software that is not only fast to release, but also secure, traceable and reliable."

**Interview tip:** Be accurate about dates, job titles, years of experience and which tools you used professionally versus in personal labs.

---

## 3. JFrog Artifactory, Xray, Curation and Nexus

### Q2. What is JFrog Artifactory?

**Answer:** JFrog Artifactory is a universal artifact repository manager. It stores, manages and distributes packages and build artifacts throughout the software development lifecycle. It supports package formats such as Maven, npm, Docker/OCI, PyPI and Helm.

It gives organizations a centralized location for internal artifacts and approved external dependencies. Benefits include caching, version management, access control, traceability, reliable distribution and CI/CD integration.

### Q3. Explain local, remote and virtual repositories.

| Type | Explanation | Example |
|---|---|---|
| Local | Stores artifacts produced or hosted by the organization. | Internally built JAR or Docker image |
| Remote | Proxies and caches an external repository. | Proxy to Maven Central |
| Virtual | Provides one logical endpoint combining selected local and remote repositories. | One Maven endpoint for developers |

A common design is to host internal releases in a local repository, proxy approved public repositories through remote repositories, and expose a virtual repository to developers and build agents.

### Q4. What is JFrog Xray?

**Answer:** JFrog Xray is a software composition analysis and security solution in the JFrog Platform. It analyzes indexed artifacts and their components to identify known vulnerabilities, license issues and policy violations. It helps teams understand dependency relationships and assess software component risk.

Policies and watches can evaluate selected resources and produce findings or enforcement signals, depending on configured integrations.

**Important:** Creating an Xray watch does not automatically block every upload or deployment. Enforcement must be connected to the relevant CI/CD, release, repository or deployment control.

### Q5. What is JFrog Curation?

**Answer:** JFrog Curation governs open-source package consumption. It can evaluate package requests against organizational policies and help prevent disallowed or risky packages from entering development workflows, subject to configured package types, repositories and policies.

### Q6. Explain Artifactory vs Xray vs Curation.

- **Artifactory:** Stores and distributes software artifacts.
- **Xray:** Analyzes artifacts and components for vulnerabilities, licenses and policy issues.
- **Curation:** Governs which open-source packages can be consumed.

Memory aid: store, analyze, govern.

### Q7. What is the difference between JFrog Artifactory and Sonatype Nexus Repository?

Both are artifact repository managers. They centralize package storage, proxy external repositories, cache dependencies and integrate with build systems.

Artifactory is part of the JFrog Platform ecosystem, including integrations with Xray and Curation. Nexus Repository is part of the Sonatype ecosystem, with related supply-chain governance and security products.

Selection depends on existing tooling, package formats, integrations, governance requirements, scale, operational skills and licensing.

### Q8. How would you configure Maven to use Artifactory?

I would configure the Maven repository endpoint in the project's or user's Maven settings, or the appropriate POM configuration, based on organizational standards. Credentials should be injected securely and never committed to source control.

Illustrative settings.xml server entry:

~~~xml
<settings>
  <servers>
    <server>
      <id>company-artifactory</id>
      <username>${env.ARTIFACTORY_USER}</username>
      <password>${env.ARTIFACTORY_TOKEN}</password>
    </server>
  </servers>
</settings>
~~~

The repository endpoint and matching repository ID must also be configured. Use an approved secrets mechanism and avoid exposing credentials in logs.

### Q9. What is artifact promotion?

Artifact promotion is the controlled movement of a validated artifact through lifecycle stages such as development, testing, staging and production.

A strong practice is to build once, validate once, then promote the same immutable artifact. Rebuilding independently for each environment can produce different outputs and weaken traceability.

### Q10. How do you version artifacts?

Use a convention such as semantic versioning where suitable: MAJOR.MINOR.PATCH. Include build metadata such as a CI run number or source commit SHA when useful.

For container images, do not rely solely on the mutable latest tag. Use unique version tags and deploy by immutable digest where possible.

### Q11. Developers report slow Maven dependency downloads. What do you investigate?

1. Confirm builds use the approved Artifactory/Nexus endpoint.
2. Inspect remote repository cache effectiveness and upstream health.
3. Check DNS, proxy, TLS, routing and network latency.
4. Review repository service health, capacity, connection limits and logs.
5. Compare the same dependency from different agents or networks.
6. Check whether a recent configuration or upstream outage caused the slowdown.
7. Document findings and add monitoring for recurring bottlenecks.

---

## 4. Software supply-chain security

### Q12. What is software supply-chain security?

It is the practice of protecting the complete path used to create and deliver software: source code, developers, third-party dependencies, build systems, CI/CD credentials, artifacts, registries, container images and deployment environments.

An attacker may target a dependency, build runner, package registry or release credential instead of attacking application source code directly.

Controls include trusted package sources, dependency governance, SAST and SCA, secret detection, SBOM generation, artifact signing, protected branches, least-privilege CI/CD identities, immutable artifact promotion, audit trails and incident response.

### Q13. What is an SBOM?

A Software Bill of Materials is a structured inventory of software components and dependencies included in a product or release. It helps identify which applications may be affected when a vulnerability is disclosed.

Common formats include SPDX and CycloneDX.

### Q14. What is SCA?

Software Composition Analysis identifies and evaluates third-party and open-source components used by an application. It helps detect known vulnerabilities, license concerns and dependency risks.

### Q15. What is SAST?

Static Application Security Testing analyzes source code or compiled representations without requiring the running application, to find potential coding weaknesses.

### Q16. Difference between SAST, SCA, DAST and container scanning?

| Control | Focus |
|---|---|
| SAST | Application source code and code-level weaknesses |
| SCA | Third-party libraries and dependencies |
| DAST | Running application behavior and exposed weaknesses |
| Container scanning | OS packages, libraries and configuration in images |
| Secret scanning | Credentials accidentally committed |
| IaC scanning | Misconfigurations in Terraform, Kubernetes and infrastructure definitions |

### Q17. How would you stop developers downloading malicious packages from public registries?

Establish controlled package access. Developers and build agents should use approved internal repository endpoints rather than unrestricted direct internet access where architecture permits.

Configure remote and virtual repositories, apply Curation policies where licensed and supported, maintain approved package rules, scan dependencies and log access. Roll out policies in stages to avoid breaking legitimate builds.

### Q18. What is artifact signing?

Artifact signing associates a cryptographic identity with an artifact or its digest. Consumers can verify that the artifact has not been altered and that it was signed by an expected identity.

For container images, tools such as Cosign can sign and verify image digests. Signing complements scanning: a signed image is not automatically vulnerability-free.

### Q19. Difference between vulnerability severity and exploitability?

Severity estimates the technical seriousness of a vulnerability. Exploitability considers whether and how realistically it can be used in a particular environment.

Prioritize using severity, exploitability, exposure, reachable code, compensating controls, business impact and remediation availability. A CVSS score is useful but should not be the only decision factor.

### Q20. What happens if Xray finds a critical vulnerability in an artifact?

1. Identify the artifact, component, version and downstream consumers.
2. Review vulnerability details, exploitability and exposure.
3. Apply the configured policy and prevent further promotion where supported.
4. Notify application owners and security stakeholders.
5. Upgrade, replace or mitigate the dependency.
6. Rebuild and rescan.
7. Publish and promote the approved replacement.
8. Retain evidence and track remediation.

If production is exposed, assess emergency patching, rollback or isolation with the incident team.

### Q21. Difference between Trivy and JFrog Xray?

Trivy is an open-source scanner that can inspect container images, filesystems, source repositories, configuration and dependencies. JFrog Xray provides analysis within the JFrog Platform and connects findings to indexed artifacts, components, policies and watches.

They can complement each other. Results can differ because databases, metadata, scope and analysis methods differ. Validate findings rather than assuming outputs are identical.

---

## 5. Jenkins and GitHub Actions

### Q22. Explain CI, continuous delivery and continuous deployment.

- **Continuous Integration:** Developers integrate changes frequently, with automated builds and tests.
- **Continuous Delivery:** Changes passing the pipeline are kept in a releasable state; production release may require approval.
- **Continuous Deployment:** Changes passing all required checks are automatically deployed to production.

### Q23. Jenkins vs GitHub Actions?

| Jenkins | GitHub Actions |
|---|---|
| Automation server that can be self-hosted | Workflow automation integrated into GitHub |
| Pipelines commonly defined in Jenkinsfiles | Workflows defined in YAML |
| Uses controller and agents | Uses hosted or self-hosted runners |
| Extensive plugin ecosystem | Marketplace actions and reusable workflows |
| Organization manages Jenkins infrastructure and plugins | Hosted runners reduce infrastructure administration |

Both can coexist. The decision depends on existing investments, integrations, governance, scalability and operational overhead.

### Q24. What is a Jenkins controller and agent?

The controller coordinates jobs, manages configuration and schedules work. Agents execute build and pipeline tasks. Distributed agents can improve scalability and isolate workloads by operating system, toolchain or trust level.

### Q25. How do you secure Jenkins?

- Enforce authentication and role-based authorization.
- Integrate an approved identity provider where appropriate.
- Store credentials in Jenkins Credentials or an external secrets manager.
- Use least-privilege service identities.
- Patch Jenkins and plugins.
- Restrict controller exposure and network access.
- Isolate build agents and avoid running untrusted pull requests on privileged agents.
- Audit administrative and pipeline activity.
- Protect pipeline definitions and shared libraries.
- Avoid printing secrets in logs.

### Q26. Explain a GitHub Actions workflow.

A workflow is a YAML definition containing triggers, jobs, runners and steps.

~~~yaml
name: Java CI

on:
  push:
    branches: [main]
  pull_request:

permissions:
  contents: read

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Set up Java
        uses: actions/setup-java@v4
        with:
          distribution: temurin
          java-version: '17'
          cache: maven

      - name: Test
        run: mvn --batch-mode clean verify
~~~

Be prepared to explain name, on, permissions, jobs, runs-on, steps, environment variables and secrets.

### Q27. How would you integrate Jenkins with Artifactory?

1. Configure the approved JFrog integration or CLI on Jenkins agents.
2. Store the JFrog access token in Jenkins Credentials or an approved secrets manager.
3. Configure the Artifactory URL and repository names as controlled pipeline configuration.
4. Check out source code and run tests.
5. Build the artifact.
6. Publish it with a unique version and build metadata.
7. Collect build information where configured.
8. Trigger or query security analysis and enforce the required policy.
9. Retain logs and traceability without exposing secrets.

Illustrative Jenkinsfile:

~~~groovy
pipeline {
  agent any

  environment {
    ARTIFACTORY_URL = 'https://artifactory.example.com'
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Test and Build') {
      steps {
        sh 'mvn --batch-mode clean verify'
      }
    }

    stage('Publish') {
      steps {
        withCredentials([
          string(
            credentialsId: 'jfrog-access-token',
            variable: 'JF_ACCESS_TOKEN'
          )
        ]) {
          sh '''
            set +x
            jf config add interview-server               --url="$ARTIFACTORY_URL"               --access-token="$JF_ACCESS_TOKEN"               --interactive=false
            jf rt upload "target/*.jar"               "libs-release-local/com/example/"
          '''
        }
      }
    }
  }
}
~~~

This is illustrative: configure the JFrog CLI version, repository layout, build-info collection and cleanup according to organizational standards. Avoid shell tracing around secrets.

### Q28. How do you secure GitHub Actions?

Use least-privilege GITHUB_TOKEN permissions, pin third-party actions to reviewed commit SHAs where required by policy, protect branches and environments, use short-lived OIDC credentials where supported, keep secrets out of logs, isolate self-hosted runners and review workflow changes.

### Q29. How do you improve pipeline performance?

Use dependency caching, parallelize independent jobs, avoid redundant builds, use appropriate runner sizes, optimize Docker layer caching, reuse tested workflow templates and measure stage duration. Do not weaken security gates merely to reduce execution time.

---

## 6. AWS, Azure and Infrastructure as Code

### Q30. What is Infrastructure as Code?

IaC defines infrastructure in version-controlled configuration and provisions it through automation. It improves repeatability, reviewability, auditability and consistency across environments.

### Q31. Terraform vs CloudFormation?

| Terraform | CloudFormation |
|---|---|
| Multi-provider IaC tool | AWS-native provisioning service |
| Uses HCL | Uses YAML or JSON |
| Uses provider plugins | Deep AWS integration |
| Uses state to map configuration to resources | Tracks resources through stacks |
| Useful for multi-cloud and mixed environments | Useful for AWS-centric environments |

Choose based on cloud scope, existing standards, team expertise, provider support and operational needs.

### Q32. Explain Terraform state.

Terraform state maps configuration resources to real infrastructure. It helps Terraform determine what exists and what changes are needed.

For teams, use remote state storage with encryption, access controls, versioning and a supported locking mechanism. Protect state because it can contain sensitive values. Do not commit state files to source control.

### Q33. What is Terraform drift?

Drift occurs when real infrastructure differs from the desired configuration. For example, someone manually changes a security group outside Terraform.

Run a plan or refresh-aware workflow, inspect the difference, establish whether it was intentional, and reconcile safely. Do not automatically overwrite production changes without understanding their purpose.

### Q34. What if Terraform plans to destroy a critical production resource?

Stop before applying. Inspect the plan, resource address, dependencies, state and recent configuration/provider changes. Determine whether the resource was renamed, removed, replaced due to an immutable attribute or affected by state inconsistency. Correct the cause, re-run the plan and obtain required review before applying.

### Q35. AWS and Azure service equivalents?

| AWS | Azure |
|---|---|
| EC2 | Azure Virtual Machines |
| S3 | Blob Storage |
| EKS | AKS |
| IAM | Microsoft Entra ID and Azure RBAC |
| VPC | Virtual Network |
| CloudWatch | Azure Monitor |
| ECR | Azure Container Registry |
| CloudFormation | ARM templates / Bicep |
| Secrets Manager | Key Vault |

Acknowledge where your hands-on experience is deeper. Cloud concepts such as identity, networking, encryption, observability and IaC transfer across providers, but implementation details differ.

### Q36. How would you provision EKS?

Use Terraform or approved IaC to provision the VPC, subnets, cluster, node groups or compute capacity, IAM roles and supporting resources. Configure cluster access, network controls, logging, encryption, add-ons and autoscaling. Deploy applications through a controlled pipeline using Helm or Kubernetes manifests. Validate workloads and monitor cluster health.

---

## 7. Docker, Kubernetes, EKS and Helm

### Q37. Docker image vs container?

An image is an immutable template containing application files, runtime and dependencies. A container is an instance created from an image.

### Q38. How do you harden a Docker image?

- Use a trusted, maintained and minimal base image.
- Pin base images by digest where appropriate.
- Run as a non-root user.
- Remove unnecessary packages and build tools from runtime images.
- Use multi-stage builds.
- Avoid embedding secrets.
- Set appropriate filesystem and Linux capability restrictions.
- Scan images and rebuild when vulnerabilities are fixed.
- Use immutable tags/digests and signing where appropriate.

### Q39. Deployment vs StatefulSet vs DaemonSet?

| Resource | Purpose |
|---|---|
| Deployment | Manages replicated, typically stateless pods |
| StatefulSet | Manages pods needing stable identities and persistent storage association |
| DaemonSet | Runs a pod on each eligible node |

### Q40. What is Helm?

Helm is a package manager for Kubernetes. A chart templates Kubernetes resources and allows environment-specific values. Helm supports release installation, upgrades, rollback and chart versioning.

### Q41. A pod is in CrashLoopBackOff. How do you troubleshoot?

~~~bash
kubectl get pods -n production
kubectl describe pod <pod-name> -n production
kubectl logs <pod-name> -n production
kubectl logs <pod-name> -n production --previous
kubectl describe deployment <deployment-name> -n production
kubectl get events -n production   --sort-by=.metadata.creationTimestamp
~~~

Investigate application startup errors, entrypoint/command, configuration, Secrets, ConfigMaps, permissions, probes, resource limits, OOM kills and external dependencies. Check previous logs and events before restarting repeatedly.

### Q42. Application works in development but fails in production. What do you compare?

Compare artifact digest, configuration, environment variables, Secrets, IAM permissions, network policies, DNS, service endpoints, resource requests/limits, storage, external dependencies and deployment values. Prefer promoting the same tested artifact across environments.

### Q43. How do you achieve zero-downtime deployments?

Use readiness probes, rolling updates with appropriate surge/unavailable settings, backward-compatible database changes, graceful shutdown, sufficient capacity and health monitoring. Blue-green or canary deployment may be suitable depending on architecture. Define rollback criteria and validate user-facing behavior.

### Q44. What is Kubernetes RBAC?

Role-Based Access Control governs who can perform which actions on Kubernetes resources. Use least-privilege Roles/ClusterRoles and RoleBindings/ClusterRoleBindings, avoid broad cluster-admin access and audit service-account permissions.

---

## 8. Linux, networking and Bash

### Q45. How do you investigate high CPU usage?

~~~bash
top
ps aux --sort=-%cpu | head
free -h
df -h
iostat -xz 1
uptime
~~~

Identify whether CPU, memory, disk I/O or external dependencies are the bottleneck. Correlate processes with logs and metrics, recent deployments, traffic and system events. Apply a fix based on evidence.

### Q46. A Linux service is not responding. What commands do you use?

~~~bash
systemctl status nginx
journalctl -u nginx -n 100 --no-pager
ss -tulnp
curl -v http://localhost:8080
getent hosts example.com
dig example.com
traceroute example.com
~~~

Check service state, logs, listening sockets, local connectivity, DNS, routing, firewall/security rules and upstream dependencies.

### Q47. Difference between TCP and UDP?

TCP is connection-oriented and provides ordered, reliable byte-stream delivery with retransmission and flow control. UDP is connectionless and provides datagrams without built-in delivery or ordering guarantees. The application chooses based on latency, reliability and protocol requirements.

### Q48. How do you investigate DNS problems?

Check name resolution using dig, nslookup or getent hosts; compare configured resolvers; inspect DNS records and TTL; test from the affected host/container; and determine whether the issue is local, resolver-side or authoritative. A successful ping does not prove application DNS and service connectivity are healthy.

### Q49. Write a Bash script to check whether a service is running.

~~~bash
#!/usr/bin/env bash
set -euo pipefail

SERVICE="nginx"

if systemctl is-active --quiet "$SERVICE"; then
  echo "$SERVICE is running"
else
  echo "$SERVICE is not running"
  exit 1
fi
~~~

Explain variables, conditionals, exit status and strict-mode behavior. In production, decide whether the script should only report status or also attempt remediation.

---

## 9. Programming and automation

### Q50. How have you used scripting in DevOps?

Discuss real examples such as automating builds, validating configuration, parsing logs, calling APIs, checking service health, processing deployment metadata or integrating tools. Explain error handling, logging, retries, secure credential handling and tests.

### Q51. How do you handle errors in Python automation?

Use exceptions for expected failure modes, validate inputs, set timeouts for network calls, use bounded retries for transient failures, log actionable context without secrets, return meaningful exit codes and test failure paths.

### Q52. How do you make automation idempotent?

Design repeated execution to converge on the same desired state without causing duplicate or harmful changes. Check current state before acting, use declarative tools where possible, and make operations safe to retry.

---

## 10. Production troubleshooting scenarios

### Q53. Jenkins pipeline suddenly fails. What do you do?

Identify the failing stage and compare recent changes. Inspect console output, controller and agent logs, tool versions, credentials, network connectivity and dependency repository health. Determine whether the failure is source-related, infrastructure-related, credential-related or caused by an upstream service. Restore service safely and document the root cause.

### Q54. Developers cannot download dependencies from Artifactory.

Check service availability, DNS, TLS certificate validity, authentication, repository permissions, remote upstream status, proxy configuration, network routes and repository logs. Test with a known package and compare from multiple agents. Avoid bypassing governance by telling developers to use public registries directly.

### Q55. A developer wants to deploy an image with a critical vulnerability.

Do not allow normal promotion to proceed. Validate the finding and exposure, identify the vulnerable component, work with the owner to upgrade or mitigate, rebuild and rescan, then publish a new artifact. An emergency exception should require documented risk acceptance, authorized approval, compensating controls and an expiry date.

### Q56. Terraform proposes destroying a production resource.

Stop the apply. Inspect the plan and state, review recent code changes and resource dependencies, determine whether a replacement or state mismatch is involved, then correct and re-plan. Require review for destructive production changes.

### Q57. Users cannot access an application running on EKS.

Check application pods and logs, readiness/liveness probes, Service selectors and endpoints, Ingress or load balancer status, DNS, security groups, network policies, routes, certificates and upstream dependencies. Trace the request from client to ingress/load balancer, service and pod.

### Q58. A certificate has expired and service traffic is failing.

Identify the affected certificate and endpoints, confirm expiry and trust chain, renew or replace it through the approved process, validate secret/certificate distribution, reload affected services safely, test the complete TLS path and add expiry monitoring.

### Q59. A public dependency is compromised.

Identify versions and applications that consumed it, block or quarantine further consumption through available controls, assess whether it reached production, rotate any exposed credentials, rebuild affected artifacts from trusted dependencies, verify integrity and coordinate incident response. Preserve logs and evidence.

### Q60. How do you handle a production incident?

Establish impact and severity, communicate with stakeholders, stabilize or mitigate the service, use evidence to isolate the fault, restore service safely, validate recovery and document the timeline. Follow up with a blameless root-cause analysis and track corrective actions.

---

## 11. Architecture and senior-level questions

### Q61. Design a secure enterprise artifact management platform.

1. Developers and CI systems use approved internal repository endpoints.
2. Artifactory or Nexus hosts internal artifacts and proxies approved upstream registries.
3. Virtual repositories provide consistent endpoints.
4. Access is controlled through identity integration and least-privilege permissions.
5. Curation or equivalent governance evaluates package consumption.
6. Xray or an appropriate scanner analyzes artifacts and dependencies.
7. SBOMs and build metadata are retained.
8. CI/CD policy gates control release and promotion.
9. Artifacts are versioned, immutable where possible and signed.
10. Logs, metrics, backups and audit records support operations.

Discuss high availability, disaster recovery, storage capacity, retention, upgrades, secrets and developer experience.

### Q62. How would you migrate an organization from direct public package downloads to centralized artifact management?

Inventory languages, package managers, dependencies and current sources. Configure remote repositories and virtual endpoints. Pilot with selected teams, update Maven/npm/Docker/Helm client configuration, validate cache and authentication, introduce policy in monitor/report mode, remediate exceptions, then progressively enforce approved sources. Monitor build success and developer adoption.

### Q63. How would you build a CI/CD platform used by multiple engineering teams?

Provide reusable pipeline templates, standardized runners/agents, centralized artifact repositories, identity and secrets integration, security checks, policy gates, environment promotion, auditability and monitoring. Establish ownership, documentation, support processes and platform SLOs. Allow controlled flexibility without duplicating insecure pipeline logic.

### Q64. How do you prevent pipeline tampering?

Protect branches and workflow files, require code review, restrict who can modify pipeline definitions, use short-lived identities and least-privilege tokens, pin external actions, isolate untrusted builds, sign artifacts and audit changes. Separate build and deployment permissions where possible.

### Q65. How do you manage secrets across cloud and CI/CD platforms?

Use approved secret managers such as AWS Secrets Manager or Azure Key Vault, or an enterprise vault. Prefer short-lived credentials and OIDC federation where supported. Restrict access, rotate secrets, audit retrieval and prevent secret values from appearing in logs, images, source code or artifacts.

### Q66. How do you measure the success of a DevOps platform?

Measure deployment frequency, lead time for changes, change failure rate, time to restore service, pipeline success rate, build duration, artifact availability, vulnerability remediation time, policy exceptions, platform availability and developer experience. Select metrics that encourage reliability and secure delivery rather than simply maximizing deployment speed.

---

## 12. Behavioral and HR questions

### Q67. Why are you interested in this position?

"I'm interested because the role goes beyond conventional DevOps operations. It combines platform engineering, automation, open-source governance and software supply-chain security. I am particularly interested in the opportunity to improve artifact management and establish secure, repeatable delivery practices across engineering teams."

### Q68. Tell me about a challenging technical problem you solved.

Use STAR:

- **Situation:** What was happening?
- **Task:** What were you responsible for?
- **Action:** What did you investigate and change?
- **Result:** What improved, and how was it measured?

Use a genuine example from professional experience or clearly identify it as a personal lab/project.

### Q69. How do you handle disagreement with developers about security requirements?

Explain the risk in practical terms, show evidence, propose a developer-friendly remediation and integrate feedback early in the pipeline. Where exceptions are necessary, require documented, approved, time-bound risk acceptance.

### Q70. What is your strongest technical area?

Choose an area you can substantiate with detailed examples. Explain the architecture, your contribution, a difficult problem, how you validated the result and what you would improve.

### Q71. What is an area you are improving?

Choose a genuine development area and explain the concrete steps you are taking. Do not describe a core job requirement as something you cannot perform.

### Q72. Are you comfortable with onsite work in Singapore and a 12-month renewable contract?

Answer honestly based on availability, relocation readiness and work authorization. Clarify sponsorship, employment arrangement, benefits, leave, insurance and renewal conditions before making commitments.

---

## 13. Questions to ask the interviewer

1. Is JFrog Artifactory and Xray already in production, or will this role also implement or improve the platform?
2. How is open-source governance currently managed? Are you using JFrog Curation or another package governance solution?
3. Are GitHub Actions and Jenkins used together, or is there a plan to standardize on one?
4. Is the cloud environment primarily AWS, Azure or hybrid?
5. What are the most important deliverables expected during the first 90 days?
6. How are artifact promotion, vulnerability exceptions and production approvals handled?
7. What is the on-call or incident support expectation for this role?
8. How is success measured for the person joining this team?

---

## 14. Practical exercises

### Exercise 1 — GitHub Actions pipeline

Write a workflow that checks out a repository, runs tests, builds an application and stores the resulting artifact. Add least-privilege permissions and explain how you would securely publish to Artifactory.

### Exercise 2 — Jenkins integration

Create a Jenkinsfile with checkout, test, build and artifact-publishing stages. Store credentials in Jenkins Credentials. Explain how you would add an Xray policy check before promotion.

### Exercise 3 — Artifactory repository design

Design a local repository for internal releases, a remote repository proxying an approved public registry, and a virtual repository exposing both. Explain authentication, permissions, caching and retention.

### Exercise 4 — Vulnerability triage

Given an image scan with High and Critical findings:
- Identify affected packages.
- Confirm image and scanner versions.
- Evaluate exploitability and reachability.
- Identify fixed versions.
- Rebuild and rescan.
- Record remediation evidence.

### Exercise 5 — Kubernetes troubleshooting

Create or inspect a Deployment with an intentionally incorrect readiness probe. Use kubectl describe, logs and events to identify and fix the issue. Explain how readiness differs from liveness.

### Exercise 6 — Terraform safety

Write a small Terraform configuration, run terraform fmt, terraform validate and terraform plan. Explain remote state, locking, sensitive values and how you would review destructive changes.

### Exercise 7 — Linux troubleshooting

Investigate a service that is stopped or unreachable. Use systemctl, journalctl, ss, curl, DNS tools and process inspection. Document root cause and recovery.

---

## 15. Seven-day preparation plan

Recommended study time: 2–3 hours per day.

| Day | Focus | Practice |
|---|---|---|
| 1 | JFrog and Nexus | Local/remote/virtual repos, Xray, Curation, CLI |
| 2 | CI/CD | GitHub Actions, Jenkins, credentials, pipeline design |
| 3 | Supply-chain security | SBOM, SCA, CVEs, signing, package governance |
| 4 | Cloud and IaC | AWS, Azure, EKS, Terraform, CloudFormation |
| 5 | Containers and Kubernetes | Docker hardening, Helm, RBAC, troubleshooting |
| 6 | Linux and scripting | Bash, networking, logs, Python automation |
| 7 | Mock interview | Architecture, scenarios, behavioral questions |

---

## 16. Mock interview question bank

Answer aloud in 2–4 minutes, then expect follow-up questions.

1. Explain the difference between Artifactory local, remote and virtual repositories.
2. How do Xray and Curation work together?
3. Design a secure pipeline from GitHub commit to Kubernetes production deployment.
4. How do you prevent vulnerable Maven packages from entering a build?
5. How would you integrate Jenkins with Artifactory?
6. Explain Terraform state, locking and drift.
7. Troubleshoot a Kubernetes CrashLoopBackOff.
8. Migrate an organization away from direct public registry access.
9. Explain SBOM, SCA and artifact signing.
10. Design a multi-team enterprise DevOps platform.
11. What would you do if an Artifactory remote repository became unavailable?
12. How would you secure self-hosted GitHub Actions runners?
13. How do you handle an exposed CI/CD token?
14. How would you investigate a Docker image that is larger than expected?
15. Explain Kubernetes readiness, liveness and startup probes.
16. How would you design artifact retention and disaster recovery?
17. How do you handle a false-positive vulnerability finding?
18. What is the difference between a tag and an image digest?
19. How do you debug a TLS handshake failure between a build agent and Artifactory?
20. What would your first 30, 60 and 90 days in this role look like?

### Self-evaluation rubric

| Score | Standard |
|---|---|
| 1–3 | Definitions are incomplete or inaccurate |
| 4–5 | Understands concepts but lacks a clear implementation approach |
| 6–7 | Gives a technically sound answer with practical steps |
| 8–9 | Explains trade-offs, security, validation and failure handling |
| 10 | Demonstrates clear production-level reasoning, ownership and measurable outcomes |

---

## 17. Official learning resources

- [JFrog Platform documentation](https://jfrog.com/help/r/jfrog-platform-administration-documentation)
- [JFrog Xray documentation](https://jfrog.com/help/r/jfrog-xray-documentation)
- [JFrog Curation documentation](https://jfrog.com/help/r/jfrog-curation-documentation)
- [Sonatype documentation](https://docs.sonatype.com/)
- [GitHub Actions documentation](https://docs.github.com/en/actions)
- [Jenkins documentation](https://www.jenkins.io/doc/)
- [Terraform documentation](https://developer.hashicorp.com/terraform/docs)
- [AWS EKS documentation](https://docs.aws.amazon.com/eks/)
- [Kubernetes documentation](https://kubernetes.io/docs/home/)
- [Helm documentation](https://helm.sh/docs/)
- [Trivy documentation](https://trivy.dev/latest/)
- [SPDX specifications](https://spdx.dev/)
- [CycloneDX documentation](https://cyclonedx.org/)

---

## 18. Your JFrog DevSecOps project

### JFrog DevSecOps: Secure Container Delivery

Repository: [Fomainspi/JFrog-DevSecOps-project](https://github.com/Fomainspi/JFrog-DevSecOps-project)

This repository demonstrates a hands-on container security workflow using Docker, Trivy, JFrog Artifactory, JFrog Xray and Kubernetes deployment controls.

The documented workflow includes:

1. Build a small Python API into a Docker image.
2. Apply container hardening, including a non-root runtime user.
3. Scan the image locally with Trivy.
4. Publish the image to the JFrog Docker local repository.
5. Index the image with Xray and inspect component vulnerabilities and SBOM information.
6. Investigate an individual vulnerability finding.
7. Define an Xray security policy and attach it to a watch.
8. Design a promotion gate and Kubernetes deployment baseline.
9. Document evidence, limitations and remediation steps.

**Recorded lab evidence:** The repository README documents a point-in-time Xray scan of secure-api:v1 with 78 findings: 17 High, 28 Medium, 33 Low and 0 Critical. The captured scan initially showed zero policy violations before a custom watch/policy was configured. These figures are historical lab observations, not current scan results or a claim that the image is universally safe.

### How to present this project

"One practical project I developed demonstrates secure container delivery. I built and hardened a Python API container, scanned it with Trivy, published it to JFrog Artifactory and used Xray to inspect indexed components and vulnerability findings.

I also documented the relationship between repository storage, vulnerability analysis, security policy and deployment enforcement. An important lesson was that storing an image and scanning it are not the same as enforcing a release gate. The CI/CD or deployment process must explicitly evaluate and enforce the security decision.

The project is documented in my GitHub repository, including the architecture, setup, findings and deployment baseline."

**Be transparent:** Demonstrate only stages you have actually completed. If asked about a planned control, explain its design and what remains to be implemented.

### Project and author links

- [Project repository](https://github.com/Fomainspi/JFrog-DevSecOps-project)
- [Project README](https://github.com/Fomainspi/JFrog-DevSecOps-project/blob/main/README.md)
- [FOMA](https://www.foma.life)
- [GitHub profile](https://github.com/Fomainspi)

---

## Final interview reminders

- Explain architecture before listing commands.
- Distinguish tools that store artifacts, scan them and enforce policy.
- Explain how you validate results and handle failures.
- Never claim a security scan guarantees an artifact is safe.
- Never expose credentials in code, screenshots or logs.
- Be clear about professional experience versus personal lab experience.
- Use real examples and measurable outcomes wherever possible.
- Ask about the team's current architecture and first-90-day expectations.

---

**William Foma**  
DevOps / DevSecOps Engineer  
Founder, FOMA — Foundation of Mastering Automation  
[https://www.foma.life](https://www.foma.life)

*Prepared as a practical interview study guide. Product capabilities and configuration details should be checked against the version and licensing of the employer's JFrog, Nexus, cloud and CI/CD platforms.*
