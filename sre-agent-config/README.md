# SRE Agent Configuration Files

## 📋 What's in This Directory

This directory contains **ready-to-use** configuration files for setting up your Azure SRE Agent. All files have been customized with your specific Azure resources and email.

### Files

1. **incident-handler-customized.yaml** (9.6 KB)
   - Subagent for automatic incident diagnosis
   - Analyzes errors, logs, metrics
   - Creates GitHub issues with root cause analysis
   - Sends email updates

2. **health-check-customized.yaml** (6.8 KB)
   - Subagent for daily health monitoring
   - Checks CPU, memory, error rates
   - Sends alerts only if anomalies detected
   - Runs automatically via scheduled task

3. **PORTAL_CONFIGURATION_GUIDE.md** (8.7 KB)
   - Detailed step-by-step instructions
   - Copy-paste values for each step
   - Troubleshooting tips
   - Screenshots descriptions

4. **QUICK_SETUP_CARD.md** (3.3 KB)
   - Quick reference with all copy-paste values
   - 5-minute setup overview
   - Handy checklist

5. **README.md** (this file)
   - Overview of all files

---

## ⚡ Quick Start

### Option 1: Fast Setup (Recommended)

```bash
cat QUICK_SETUP_CARD.md
```

Has everything in one place - just copy and paste!

### Option 2: Detailed Walkthrough

```bash
cat PORTAL_CONFIGURATION_GUIDE.md
```

Comprehensive instructions with explanations.

---

## 🔗 Portal Access

**SRE Agent Portal:**
https://ms.portal.azure.com/#view/Microsoft_Azure_PaasServerless/AgentFrameBlade.ReactView/id/%2Fsubscriptions%2F23835f6b-9ad7-4c33-b0b8-55157ad0d2b5%2FresourceGroups%2Frg-sre-agent-demo%2Fproviders%2FMicrosoft.App%2Fagents%2Foctopets-sre-agent

**Bookmark this link!**

---

## ✅ Pre-Configured Values

All YAML files already include:

- **Email:** prafullawani@microsoft.com
- **Subscription:** 23835f6b-9ad7-4c33-b0b8-55157ad0d2b5
- **Resource Group:** rg-octopets-sre-demo
- **Container Apps:** octopetsapi, octopetsfe
- **Application Insights:** octopets_appinsights-w2shk6ckv6at4
- **GitHub Repo:** https://github.com/prwani/octopets-sre-demo

**No editing required** - just copy and paste!

---

## 🎯 What You Need to Do

These steps require Azure Portal (no CLI equivalent):

1. **Step 1:** Connect Outlook (⏭️ skip for now)
2. **Step 2:** Connect GitHub repository (3 min)
3. **Step 3:** Create incident handler subagent (5 min)
4. **Step 4:** Create health check subagent (5 min)
5. **Step 5:** Schedule daily health check (3 min)

**Total time: ~15-20 minutes**

---

## 📧 Email Notifications

**Recipient:** prafullawani@microsoft.com

**Incident Handler sends:**
- Incident acknowledgment
- Diagnostic findings
- Code analysis
- GitHub issue created
- Final summary

**Health Check sends:**
- Alerts ONLY if anomalies detected
- No email if everything is healthy

---

## 🧪 Testing

After setup, test the incident handler:

1. Go to Subagent Builder → AzureResourceErrorHandler → Playground
2. Use this test prompt:

```
container app octopetsapi in resource group rg-octopets-sre-demo with subscription ID 23835f6b-9ad7-4c33-b0b8-55157ad0d2b5 is experiencing errors, can you troubleshoot and find root cause, skip getting info from pagerduty and proceed
```

3. Watch the agent diagnose the issue in real-time

---

## 📚 Additional Resources

- **Complete deployment info:** `/home/prwani_u/github_copilot/SRE_AGENT_COMPLETE_SETUP.md`
- **Octopets details:** `/home/prwani_u/github_copilot/octopets/DEPLOYMENT_SUMMARY.md`
- **Quick reference:** `/home/prwani_u/github_copilot/octopets/QUICK_START.md`

---

## 🆘 Need Help?

Common issues and solutions are in `PORTAL_CONFIGURATION_GUIDE.md` under "Need Help?" section.

---

**Ready?** Start with `QUICK_SETUP_CARD.md` and you'll be done in 15 minutes!
