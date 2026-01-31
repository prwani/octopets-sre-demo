# Azure SRE Agent Complete Deployment Summary

## 🎉 DEPLOYMENT COMPLETE - ALL PHASES SUCCESSFUL!

This document contains the complete deployment information for both the Octopets application and the Azure SRE Agent.

---

## 📋 Phase 1: Octopets Application

### Deployment Details

**Subscription ID:** `23835f6b-9ad7-4c33-b0b8-55157ad0d2b5`  
**Resource Group:** `rg-octopets-sre-demo`  
**Region:** `eastus2`  
**Environment Name:** `octopets-sre-demo`

### Application URLs

| Component | URL |
|-----------|-----|
| **Frontend (UI)** | https://octopetsfe.lemonbay-f7324bec.eastus2.azurecontainerapps.io |
| **Backend API** | https://octopetsapi.lemonbay-f7324bec.eastus2.azurecontainerapps.io |
| **Aspire Dashboard** | https://aspire-dashboard.ext.lemonbay-f7324bec.eastus2.azurecontainerapps.io |

### GitHub Repository

**Repository:** https://github.com/prwani/octopets-sre-demo  
**Branch:** `main`

### Octopets Resources

| Resource | Name |
|----------|------|
| Frontend Container App | `octopetsfe` |
| Backend Container App | `octopetsapi` |
| Container Registry | `acrw2shk6ckv6at4` |
| Application Insights | `octopets_appinsights-w2shk6ckv6at4` |
| Log Analytics | `law-w2shk6ckv6at4` |
| Managed Environment | `cae-w2shk6ckv6at4` |
| Managed Identity | `mi-w2shk6ckv6at4` |

### Error Generation Configuration ✅

- **Frontend:** `REACT_APP_USE_MOCK_DATA=false`
- **Backend:** `Errors=true` (memory leak injection enabled)

---

## 🤖 Phase 2: Azure SRE Agent

### Deployment Details

**Resource Group:** `rg-sre-agent-demo`  
**Region:** `eastus2`  
**Agent Name:** `octopets-sre-agent`  
**Access Level:** `High` (Contributor + Log Analytics Reader)  
**Target Resource Groups:** `rg-octopets-sre-demo` (full access granted)

### SRE Agent Resources

| Resource | Name | Purpose |
|----------|------|---------|
| **SRE Agent** | `octopets-sre-agent` | Main agent instance |
| **Managed Identity** | `octopets-sre-agent-7tn5lrsfwt5s6` | Identity for Azure access |
| **Application Insights** | `app-insights-7tn5lrsfwt5s6` | Agent telemetry |
| **Log Analytics** | `workspace7tn5lrsfwt5s6` | Agent logs |
| **Action Group** | `Application Insights Smart Detection` | Alert actions |
| **Smart Alert Rule** | `Failure Anomalies - app-insights-7tn5lrsfwt5s6` | Anomaly detection |

### SRE Agent Access URLs

**Azure Portal:** https://ms.portal.azure.com/#view/Microsoft_Azure_PaasServerless/AgentFrameBlade.ReactView/id/%2Fsubscriptions%2F23835f6b-9ad7-4c33-b0b8-55157ad0d2b5%2FresourceGroups%2Frg-sre-agent-demo%2Fproviders%2FMicrosoft.App%2Fagents%2Foctopets-sre-agent

### Permissions Granted

The SRE Agent has the following roles on `rg-octopets-sre-demo`:
- ✅ **Contributor** - Full management of resources
- ✅ **Log Analytics Reader** - Access to logs and metrics
- ✅ **Reader** - Read access to all resources

---

## 🏗️ Infrastructure Overview

### Resource Distribution

```
Subscription: 23835f6b-9ad7-4c33-b0b8-55157ad0d2b5
├── rg-octopets-sre-demo (eastus2)
│   ├── Container Apps (2)
│   │   ├── octopetsfe (Frontend with React)
│   │   └── octopetsapi (Backend API with error injection)
│   ├── Container Registry
│   │   └── acrw2shk6ckv6at4.azurecr.io
│   ├── Monitoring
│   │   ├── Application Insights: octopets_appinsights-w2shk6ckv6at4
│   │   └── Log Analytics: law-w2shk6ckv6at4
│   ├── Container Apps Environment
│   │   └── cae-w2shk6ckv6at4
│   └── Managed Identity
│       └── mi-w2shk6ckv6at4
│
└── rg-sre-agent-demo (eastus2)
    ├── SRE Agent
    │   └── octopets-sre-agent (with access to rg-octopets-sre-demo)
    ├── Monitoring
    │   ├── Application Insights: app-insights-7tn5lrsfwt5s6
    │   └── Log Analytics: workspace7tn5lrsfwt5s6
    ├── Managed Identity
    │   └── octopets-sre-agent-7tn5lrsfwt5s6
    └── Alerting
        ├── Action Group: Application Insights Smart Detection
        └── Smart Alert: Failure Anomalies
```

### All Resources Tagged With:
- `CreatedBy`: `GithubCopilotCLI`
- `CreatedFor`: `SREAgentSetup`

---

## 🧪 Testing the Demo

### Step 1: Verify Application is Running

Open the frontend URL in your browser:
```
https://octopetsfe.lemonbay-f7324bec.eastus2.azurecontainerapps.io
```

### Step 2: Trigger Memory Leak for SRE Agent Testing

To generate errors that the SRE Agent can detect and diagnose:

1. Open the Octopets frontend
2. Click **"Browse Listings"**
3. Select any product → Click **"View Details"**
4. **REPEAT step 3 FIVE TIMES** with different products
5. Observe: 500 errors, slow responses, high memory usage

### Step 3: Monitor in Application Insights

**Using Azure Portal:**
1. Go to: `rg-octopets-sre-demo` → `octopets_appinsights-w2shk6ckv6at4`
2. View **Failures** (500 errors will appear)
3. View **Performance** (degraded response times)
4. View **Metrics** (memory consumption spike)

**Using Azure CLI:**
```bash
# View recent exceptions
az monitor app-insights query \
  --apps octopets_appinsights-w2shk6ckv6at4 \
  --resource-group rg-octopets-sre-demo \
  --analytics-query "exceptions | where timestamp > ago(1h) | take 20"

# View failed requests
az monitor app-insights query \
  --apps octopets_appinsights-w2shk6ckv6at4 \
  --resource-group rg-octopets-sre-demo \
  --analytics-query "requests | where success == false and timestamp > ago(1h) | take 20"
```

---

## ⚙️ SRE Agent Configuration Steps

Now that both the application and SRE Agent are deployed, complete these configuration steps in the Azure Portal:

### Step 1: Access the SRE Agent

Click this link to open the SRE Agent in Azure Portal:
https://ms.portal.azure.com/#view/Microsoft_Azure_PaasServerless/AgentFrameBlade.ReactView/id/%2Fsubscriptions%2F23835f6b-9ad7-4c33-b0b8-55157ad0d2b5%2FresourceGroups%2Frg-sre-agent-demo%2Fproviders%2FMicrosoft.App%2Fagents%2Foctopets-sre-agent

### Step 2: Connect Outlook for Notifications

1. In SRE Agent portal, go to **Settings** → **Connectors**
2. Click **Add Connector** → Select **Outlook**
3. Sign in with your Outlook/M365 account
4. Select **System Assigned Managed Identity**
5. Name: `SRE Agent Notifications`
6. Click **Save**

### Step 3: Connect GitHub Repository

1. Go to **Resource Mapping** tab
2. Find these resources:
   - `octopetsapi` (Container App in rg-octopets-sre-demo)
   - `octopetsfe` (Container App in rg-octopets-sre-demo)
3. For each resource:
   - Click **Connect Repository**
   - Enter: `https://github.com/prwani/octopets-sre-demo`
   - Click **Authorize**
   - Grant GitHub access
4. Verify status shows "Connected"

### Step 4: Create Incident Automation Subagent

1. Go to **Subagent Builder**
2. Click **+ New Subagent**
3. Configure:
   - **Name:** `AzureResourceErrorHandler`
   - **Description:** `Handles Azure Container App errors and performs root cause analysis`
4. Click **Create**
5. Click **Edit** → Select **YAML** tab
6. Copy the YAML from: https://github.com/microsoft/sre-agent/blob/main/samples/automation/subagents/pd-azure-resource-error-handler.yaml
7. **Important:** Update the email address in the YAML:
   - Find: `send an email update to <insert your email>`
   - Replace with your actual email
8. Click **Save**

### Step 5: Create Health Check Subagent

1. Go to **Subagent Builder**
2. Click **+ New Subagent**
3. Configure:
   - **Name:** `HealthCheckAgent`
   - **Description:** `Performs daily health checks on Octopets application`
4. Click **Create**
5. Click **Edit** → Select **YAML** tab
6. Copy the YAML from: https://github.com/microsoft/sre-agent/blob/main/samples/automation/subagents/azurehealthcheck.yaml
7. **Important:** Update the email address in the YAML:
   - Find: `Default recipient email: your email`
   - Replace with your actual email
8. Click **Save**

### Step 6: Set Up Scheduled Health Check

1. Go to **Scheduled Tasks**
2. Click **+ New Scheduled Task**
3. Configure:
   - **Task Name:** `Daily Octopets Health Check`
   - **Response Subagent:** Select `HealthCheckAgent`
   - **Task Details:** `check health of octopetsapi and octopetsfe in resource group rg-octopets-sre-demo`
   - **Frequency:** `Daily`
   - **Time:** `8:00 AM`
   - **Start Date:** Select today or tomorrow
   - **Message Grouping:** `New thread for each run`
4. Click **Save**

### Step 7: Test the Subagent (Optional)

1. Open `AzureResourceErrorHandler` subagent
2. Click **Playground**
3. Click **2 Window View**
4. Enter this test prompt:
```
container app octopetsapi in resource group rg-octopets-sre-demo with subscription ID 23835f6b-9ad7-4c33-b0b8-55157ad0d2b5 is experiencing errors, can you troubleshoot and find root cause
```
5. Monitor the agent's response to verify it can access Azure resources

### Step 8: Set Up Incident Trigger (Optional - For Production)

If you want to integrate with incident management platforms:

1. Go to **Subagent Builder**
2. Click **Create Incident Trigger**
3. Configure:
   - **Name:** `Azure 500 Error Trigger`
   - **Filters:** Configure for 500 errors and Container App failures
   - **Processing Mode:**
     - `Review` - Agent suggests actions, waits for approval
     - `Autonomous` - Agent executes actions automatically
4. Click **Create**

---

## 📊 Monitoring and Observability

### Octopets Application Monitoring

**Application Insights:**
- Name: `octopets_appinsights-w2shk6ckv6at4`
- Connection String: Available in Container App environment variables
- Portal: Azure Portal → rg-octopets-sre-demo → octopets_appinsights-w2shk6ckv6at4

**Key Metrics to Monitor:**
- Request count and success rate
- Response times (P50, P95, P99)
- Exception count and types
- Memory consumption
- CPU usage

### SRE Agent Monitoring

**Application Insights:**
- Name: `app-insights-7tn5lrsfwt5s6`
- Portal: Azure Portal → rg-sre-agent-demo → app-insights-7tn5lrsfwt5s6

**What to Monitor:**
- Agent execution logs
- Subagent performance
- API calls to Azure resources
- Alert triggers and responses

---

## 🔧 Useful Commands

### Octopets Management

```bash
# View all Octopets resources
az resource list --resource-group rg-octopets-sre-demo -o table

# Check Container App status
az containerapp show --name octopetsapi --resource-group rg-octopets-sre-demo --query "properties.runningStatus"
az containerapp show --name octopetsfe --resource-group rg-octopets-sre-demo --query "properties.runningStatus"

# View Container App logs
az containerapp logs show --name octopetsapi --resource-group rg-octopets-sre-demo --follow
az containerapp logs show --name octopetsfe --resource-group rg-octopets-sre-demo --follow

# Restart Container Apps (to clear memory leak)
az containerapp revision restart --name octopetsapi --resource-group rg-octopets-sre-demo
az containerapp revision restart --name octopetsfe --resource-group rg-octopets-sre-demo

# Update environment variables
az containerapp update --name octopetsapi --resource-group rg-octopets-sre-demo \
  --set-env-vars "Errors=false"  # Disable error generation
```

### SRE Agent Management

```bash
# View all SRE Agent resources
az resource list --resource-group rg-sre-agent-demo -o table

# View SRE Agent details
az resource show \
  --ids "/subscriptions/23835f6b-9ad7-4c33-b0b8-55157ad0d2b5/resourceGroups/rg-sre-agent-demo/providers/Microsoft.App/agents/octopets-sre-agent"

# View role assignments on Octopets resources
az role assignment list --resource-group rg-octopets-sre-demo \
  --query "[?principalName=='octopets-sre-agent-7tn5lrsfwt5s6'].{Role:roleDefinitionName,Scope:scope}" -o table
```

### Combined Monitoring

```bash
# Check all resources with our tags
az resource list --tag CreatedBy=GithubCopilotCLI -o table

# View Application Insights for both
echo "=== Octopets App Insights ===" && \
az monitor app-insights component show --app octopets_appinsights-w2shk6ckv6at4 --resource-group rg-octopets-sre-demo -o table && \
echo "=== SRE Agent App Insights ===" && \
az monitor app-insights component show --app app-insights-7tn5lrsfwt5s6 --resource-group rg-sre-agent-demo -o table
```

---

## 🧹 Clean Up Resources

When you're done with the demo, clean up all resources:

### Option 1: Delete Both Resource Groups

```bash
# Delete Octopets resources
az group delete --name rg-octopets-sre-demo --yes --no-wait

# Delete SRE Agent resources
az group delete --name rg-sre-agent-demo --yes --no-wait
```

### Option 2: Delete Individual Resource Groups

```bash
# Keep SRE Agent, delete only Octopets
az group delete --name rg-octopets-sre-demo --yes --no-wait

# Keep Octopets, delete only SRE Agent
az group delete --name rg-sre-agent-demo --yes --no-wait
```

### Option 3: Use azd to clean up Octopets

```bash
cd /home/prwani_u/github_copilot/octopets/apphost
export PATH="$HOME/.dotnet:$PATH"
azd down
```

---

## 📚 Documentation References

### Official Documentation

**Azure SRE Agent:**
- Overview: https://learn.microsoft.com/en-us/azure/sre-agent/
- Incident Management: https://learn.microsoft.com/en-us/azure/sre-agent/incident-management

**Sample Documentation:**
- Octopets Setup: https://github.com/microsoft/sre-agent/blob/main/samples/automation/sample-apps/octopets-setup.md
- SRE Agent Configuration: https://github.com/microsoft/sre-agent/blob/main/samples/automation/configuration/00-configure-sre-agent.md
- Incident Automation: https://github.com/microsoft/sre-agent/blob/main/samples/automation/samples/01-incident-automation-sample.md
- Health Check Automation: https://github.com/microsoft/sre-agent/blob/main/samples/automation/samples/02-scheduled-health-check-sample.md
- Bicep Deployment: https://github.com/microsoft/sre-agent/blob/main/samples/bicep-deployment/deployment-guide.md

**Azure Services:**
- Container Apps: https://learn.microsoft.com/azure/container-apps/
- Application Insights: https://learn.microsoft.com/azure/azure-monitor/app/app-insights-overview
- Managed Identities: https://learn.microsoft.com/azure/active-directory/managed-identities-azure-resources/

---

## 🎯 What You've Accomplished

✅ **Phase 1:** Deployed Octopets sample application with error generation  
✅ **Phase 2:** Deployed Azure SRE Agent with full permissions  
✅ **Phase 3:** Configured error injection in the application  
✅ **Phase 4:** Published code to GitHub repository  
✅ **Phase 5:** Tagged all resources for tracking  
✅ **Phase 6:** Documented configuration and testing procedures  

### Ready for Next Steps:
- Configure SRE Agent connectors (Outlook, GitHub)
- Create and configure subagents for automation
- Set up scheduled health checks
- Test incident automation workflows
- Monitor and optimize agent performance

---

## 🆘 Troubleshooting

### Issue: Container App Not Responding

**Check status:**
```bash
az containerapp show --name octopetsapi --resource-group rg-octopets-sre-demo \
  --query "{Name:name,Status:properties.runningStatus,Health:properties.health}" -o table
```

**View logs:**
```bash
az containerapp logs show --name octopetsapi --resource-group rg-octopets-sre-demo --tail 100
```

### Issue: SRE Agent Can't Access Resources

**Verify permissions:**
```bash
az role assignment list --assignee $(az identity show \
  --name octopets-sre-agent-7tn5lrsfwt5s6 \
  --resource-group rg-sre-agent-demo \
  --query principalId -o tsv) --resource-group rg-octopets-sre-demo -o table
```

Expected roles:
- Contributor
- Log Analytics Reader
- Reader

### Issue: No Telemetry in Application Insights

**Check connection string:**
```bash
az containerapp show --name octopetsapi --resource-group rg-octopets-sre-demo \
  --query "properties.template.containers[0].env[?name=='APPLICATIONINSIGHTS_CONNECTION_STRING'].value" -o tsv
```

### Issue: GitHub Connection Fails

1. Verify GitHub repository exists: https://github.com/prwani/octopets-sre-demo
2. Check GitHub permissions (repo must be accessible by your account)
3. Try re-authorizing in SRE Agent portal

---

## 📝 Notes

### Deployment Summary
- **Total Resource Groups:** 2
- **Total Resources:** 13 (7 Octopets + 6 SRE Agent)
- **Deployment Time:** ~15 minutes
- **Region:** eastus2
- **Cost Estimate:** Pay-as-you-go (Container Apps scale to zero when idle)

### Security
- All resources use Managed Identities (no credentials stored)
- SRE Agent has role-based access to Octopets resources
- GitHub repository is public (contains sample code only)
- Application Insights connection strings stored as secrets

### Limitations
- PagerDuty/ServiceNow integration not configured (no accounts available)
- Manual steps required for Portal-based configuration
- Some subagent YAML configuration requires email address updates

---

**Deployment Completed By:** GitHub Copilot CLI  
**Deployment Date:** January 31, 2026  
**Status:** ✅ All Phases Complete - Ready for Configuration
