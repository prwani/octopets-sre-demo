# SRE Agent Quick Setup Card

## 🔗 Portal Access
https://ms.portal.azure.com/#view/Microsoft_Azure_PaasServerless/AgentFrameBlade.ReactView/id/%2Fsubscriptions%2F23835f6b-9ad7-4c33-b0b8-55157ad0d2b5%2FresourceGroups%2Frg-sre-agent-demo%2Fproviders%2FMicrosoft.App%2Fagents%2Foctopets-sre-agent

---

## ⚡ 5-Minute Setup

### Step 2: Connect GitHub (3 min)
**Tab:** Resource Mapping

**For octopetsapi:**
- Click "Connect Repository"
- URL: `https://github.com/prwani/octopets-sre-demo`
- Click "Authorize"

**For octopetsfe:**
- Repeat same process

---

### Step 3: Create Incident Handler (5 min)
**Tab:** Subagent Builder → + New Subagent

**Name:** `AzureResourceErrorHandler`

**Description:** `Handles Azure Container App errors and performs root cause analysis`

**YAML:** Copy from:
```
/home/prwani_u/github_copilot/sre-agent-config/incident-handler-customized.yaml
```

Steps:
1. Create subagent
2. Edit → YAML tab
3. Delete all → Paste YAML
4. Save

---

### Step 4: Create Health Check (5 min)
**Tab:** Subagent Builder → + New Subagent

**Name:** `HealthCheckAgent`

**Description:** `Performs daily health checks on Octopets Container Apps`

**YAML:** Copy from:
```
/home/prwani_u/github_copilot/sre-agent-config/health-check-customized.yaml
```

Steps:
1. Create subagent
2. Edit → YAML tab
3. Delete all → Paste YAML
4. Save

---

### Step 5: Schedule Health Check (3 min)
**Tab:** Scheduled Tasks → + New Scheduled Task

**Copy-Paste Values:**

```
Task Name: Daily Octopets Health Check

Response Subagent: HealthCheckAgent

Task Details: check health of octopetsapi and octopetsfe container apps in resource group rg-octopets-sre-demo with subscription ID 23835f6b-9ad7-4c33-b0b8-55157ad0d2b5

Frequency: Daily

Time: 08:00

Time Zone: (UTC) Coordinated Universal Time

Message Grouping: New thread for each run
```

Click **Save**

---

## 🧪 Test (Optional - 5 min)

**Tab:** Subagent Builder → AzureResourceErrorHandler → Playground

**Test Prompt:**
```
container app octopetsapi in resource group rg-octopets-sre-demo with subscription ID 23835f6b-9ad7-4c33-b0b8-55157ad0d2b5 is experiencing errors, can you troubleshoot and find root cause, skip getting info from pagerduty and proceed
```

---

## 📋 Checklist

- [ ] Step 2: GitHub connected to both apps
- [ ] Step 3: Incident handler created
- [ ] Step 4: Health check created
- [ ] Step 5: Daily task scheduled
- [ ] Step 6: Tested in playground (optional)

---

## 📧 Email Notifications

**Recipient:** prafullawani@microsoft.com

**Incident Handler sends emails for:**
- Incident acknowledgment
- Diagnostic findings
- Code analysis results
- GitHub issue created
- Final summary

**Health Check sends emails for:**
- Anomalies detected (ONLY if problems found)
- No email if everything is healthy

---

## 🔗 Important Links

**GitHub Repo:** https://github.com/prwani/octopets-sre-demo

**Frontend:** https://octopetsfe.lemonbay-f7324bec.eastus2.azurecontainerapps.io

**Backend:** https://octopetsapi.lemonbay-f7324bec.eastus2.azurecontainerapps.io

**App Insights:** rg-octopets-sre-demo → octopets_appinsights-w2shk6ckv6at4

---

## 📚 Full Guide

For detailed instructions: `/home/prwani_u/github_copilot/sre-agent-config/PORTAL_CONFIGURATION_GUIDE.md`

---

**Total Time: ~15-20 minutes**

*Configuration files already customized with your subscription, resource group, and email!*
