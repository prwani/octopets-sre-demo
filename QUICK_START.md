# Quick Start Guide - Azure SRE Agent Demo

## 🚀 Your Deployment is Ready!

### Access Your Application
**Frontend URL:** https://octopetsfe.lemonbay-f7324bec.eastus2.azurecontainerapps.io

### Key Information
- **Resource Group:** `rg-octopets-sre-demo`
- **Subscription:** `23835f6b-9ad7-4c33-b0b8-55157ad0d2b5`
- **Region:** `eastus2`
- **GitHub Repo:** https://github.com/prwani/octopets-sre-demo

---

## 🧪 Test Error Generation (5 steps)

1. Open: https://octopetsfe.lemonbay-f7324bec.eastus2.azurecontainerapps.io
2. Click "Browse Listings"
3. Select a product → Click "View Details"
4. Repeat step 3 **FIVE TIMES** with different products
5. Watch for 500 errors and slow responses

---

## 🤖 Configure SRE Agent (Next Steps)

### Prerequisites
- [ ] Deploy Azure SRE Agent in your subscription
- [ ] Have Outlook/M365 account for notifications
- [ ] (Optional) PagerDuty or ServiceNow account

### Configuration Steps

1. **Connect Outlook**
   - Settings → Connectors → Add Outlook
   - Use System Assigned Managed Identity

2. **Connect GitHub**
   - Resource Mapping tab
   - Find `octopetsapi` and `octopetsfe`
   - Connect to: `https://github.com/prwani/octopets-sre-demo`

3. **Create Subagent**
   - Subagent Builder → Create
   - Name: `AzureResourceErrorHandler`
   - Use YAML: https://github.com/microsoft/sre-agent/blob/main/samples/automation/subagents/pd-azure-resource-error-handler.yaml

4. **Set Up Health Check**
   - Scheduled Tasks → New Task
   - Daily at 8:00 AM
   - Use YAML: https://github.com/microsoft/sre-agent/blob/main/samples/automation/subagents/azurehealthcheck.yaml

---

## 📚 Full Documentation

See `DEPLOYMENT_SUMMARY.md` for complete details, commands, and troubleshooting.

---

## 🧹 Clean Up When Done

```bash
az group delete --name rg-octopets-sre-demo --yes --no-wait
```

