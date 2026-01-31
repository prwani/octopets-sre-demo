# Azure SRE Agent Demo - Deployment Summary

## ✅ Deployment Completed Successfully!

This document contains all the details about your Azure SRE Agent demo deployment.

---

## 📋 Deployment Details

### Azure Resources

**Subscription ID:** `23835f6b-9ad7-4c33-b0b8-55157ad0d2b5`  
**Resource Group:** `rg-octopets-sre-demo`  
**Region:** `eastus2`  
**Environment Name:** `octopets-sre-demo`

### Container Apps

| Name | Type | URL |
|------|------|-----|
| **octopetsfe** | Frontend | https://octopetsfe.lemonbay-f7324bec.eastus2.azurecontainerapps.io |
| **octopetsapi** | Backend API | https://octopetsapi.lemonbay-f7324bec.eastus2.azurecontainerapps.io |

### Other Resources

- **Container Registry:** `acrw2shk6ckv6at4.azurecr.io`
- **Application Insights:** `octopets_appinsights-w2shk6ckv6at4`
- **Log Analytics Workspace:** `law-w2shk6ckv6at4`
- **Managed Environment:** `cae-w2shk6ckv6at4`
- **Aspire Dashboard:** https://aspire-dashboard.ext.lemonbay-f7324bec.eastus2.azurecontainerapps.io

### Application Insights Connection String
```
InstrumentationKey=ac3413fd-e827-4af4-9d3b-d0c2508c8e69;IngestionEndpoint=https://eastus2-3.in.applicationinsights.azure.com/;LiveEndpoint=https://eastus2.livediagnostics.monitor.azure.com/;ApplicationId=eb403902-af58-428b-aee1-ffe38d65bde0
```

### GitHub Repository

**Repository:** https://github.com/prwani/octopets-sre-demo  
**Branch:** `main`

### Resource Tags

All resources have been tagged with:
- `CreatedBy`: `GithubCopilotCLI`
- `CreatedFor`: `SREAgentSetup`

---

## ⚙️ Configuration Status

### Error Generation - ENABLED ✅

The application is configured to generate errors for testing SRE Agent:

**Frontend (octopetsfe):**
- `REACT_APP_USE_MOCK_DATA=false` ✅

**Backend (octopetsapi):**
- `Errors=true` ✅

---

## 🧪 Testing the Application

### 1. Access the Application

Open your browser and navigate to:
```
https://octopetsfe.lemonbay-f7324bec.eastus2.azurecontainerapps.io/
```

### 2. Trigger Memory Leak Error (For SRE Agent Testing)

To generate a memory leak scenario that SRE Agent can detect and diagnose:

1. Open the Octopets frontend URL
2. Click **"Browse Listings"**
3. Select any product and click **"View Details"**
4. **Repeat step 3 five times** with different products

**Expected Behavior:**
- After a few iterations, the backend will start consuming excessive memory
- Response times will increase significantly
- The application will begin throwing 500 errors
- The "View Details" page will become slow or unresponsive

### 3. Monitor in Application Insights

You can monitor the errors and performance in Application Insights:

**Using Azure Portal:**
1. Navigate to: Azure Portal → Resource Group `rg-octopets-sre-demo` → Application Insights `octopets_appinsights-w2shk6ckv6at4`
2. View **Failures** to see 500 errors
3. View **Performance** to see degraded response times
4. View **Metrics** to see memory consumption increasing

**Using Azure CLI:**
```bash
# View recent exceptions
az monitor app-insights query \
  --apps octopets_appinsights-w2shk6ckv6at4 \
  --resource-group rg-octopets-sre-demo \
  --analytics-query "exceptions | where timestamp > ago(1h) | order by timestamp desc | take 20"

# View failed requests
az monitor app-insights query \
  --apps octopets_appinsights-w2shk6ckv6at4 \
  --resource-group rg-octopets-sre-demo \
  --analytics-query "requests | where success == false and timestamp > ago(1h) | order by timestamp desc | take 20"
```

---

## 🤖 Next Steps: Configure Azure SRE Agent

Now that your Octopets application is deployed and configured, follow these steps to set up Azure SRE Agent for automated incident management.

### Prerequisites Checklist

Before proceeding, ensure you have:
- ✅ Azure SRE Agent deployed in your Azure subscription
- ✅ Application deployed and running (Octopets - completed above)
- ✅ GitHub account with repository access (prwani/octopets-sre-demo)
- ✅ Outlook/Microsoft 365 account for notifications
- ⚠️ (Optional) Incident management platform account (PagerDuty, ServiceNow, or Azure Monitor Alerts)

### Step-by-Step Configuration

#### Step 1: Deploy Azure SRE Agent (If Not Already Done)

If you haven't deployed SRE Agent yet:
1. Visit: https://learn.microsoft.com/en-us/azure/sre-agent/usage
2. Follow the deployment guide
3. Use the same subscription: `23835f6b-9ad7-4c33-b0b8-55157ad0d2b5`
4. Connect it to your application

#### Step 2: Connect to Incident Management Platform (Optional)

**Note:** Since we don't have access to PagerDuty or ServiceNow, you can skip this and use Azure Monitor Alerts directly, or proceed with manual testing.

For detailed instructions if needed: https://learn.microsoft.com/en-us/azure/sre-agent/incident-management

#### Step 3: Set Up Outlook Connector

1. In your SRE Agent, go to **Settings** → **Connectors**
2. Click **Add Connector** or select **Outlook**
3. Login with your Outlook email address
4. Select **System Assigned Managed Identity** for authentication
5. Name your connector (e.g., "SRE Agent Notifications")
6. Click **Save**

#### Step 4: Connect to GitHub Repository

1. In your SRE Agent, go to **Resource Mapping** tab
2. Find these resources:
   - `octopetsapi` (Container App)
   - `octopetsfe` (Container App)
3. For each resource:
   - Click **Connect Repository**
   - Enter: `https://github.com/prwani/octopets-sre-demo`
   - Click **Authorize** to grant access
4. Verify connection shows as "Connected"

#### Step 5: Create Subagent for Azure Errors

1. Go to **Subagent Builder**
2. Click **Create Subagent**
3. Configure:
   - **Name:** `AzureResourceErrorHandler`
   - **Instructions:** "Handles Azure resource errors and performs root cause analysis"
   - **Handoff Instructions:** "Activate for incidents with 500 errors or Azure resource failures"
4. Click **Save**

#### Step 6: Configure Subagent with YAML

Use the YAML template from the SRE Agent repository:
- Template: https://github.com/microsoft/sre-agent/blob/main/samples/automation/subagents/pd-azure-resource-error-handler.yaml

**Important:** Update the email address in the YAML:
- Find: `send an email update to <insert your email>`
- Replace with your actual email address

#### Step 7: Set Up Incident Trigger (Optional)

If using an incident management platform:

1. Go to **Subagent Builder** → **Create Incident Trigger**
2. Configure:
   - **Name:** "Azure 500 Error Trigger"
   - **Filters:** Configure for 500 errors and Azure resource failures
   - **Mode:** Choose "Review" (for manual approval) or "Autonomous" (automatic)
3. Click **Create**

#### Step 8: Set Up Scheduled Health Check

For automated daily health checks:

1. In SRE Agent, go to **Scheduled Tasks**
2. Click **+ New Scheduled Task**
3. Configure:
   - **Task Name:** `Daily Octopets Health Check`
   - **Response Subagent:** Select your health check agent
   - **Task Details:** `check health of octopetsapi and octopetsfe`
   - **Frequency:** `Daily`
   - **Time:** `8:00 AM` (or preferred time)
   - **Message Grouping:** `New thread for each run`
4. Click **Save**

Health Check YAML Template:
- Template: https://github.com/microsoft/sre-agent/blob/main/samples/automation/subagents/azurehealthcheck.yaml

---

## 📚 Documentation References

### Sample Documentation
1. **Octopets Setup:** https://github.com/microsoft/sre-agent/blob/main/samples/automation/sample-apps/octopets-setup.md
2. **SRE Agent Configuration:** https://github.com/microsoft/sre-agent/blob/main/samples/automation/configuration/00-configure-sre-agent.md
3. **Incident Automation Sample:** https://github.com/microsoft/sre-agent/blob/main/samples/automation/samples/01-incident-automation-sample.md
4. **Scheduled Health Check Sample:** https://github.com/microsoft/sre-agent/blob/main/samples/automation/samples/02-scheduled-health-check-sample.md

### Azure Documentation
- **Azure SRE Agent:** https://learn.microsoft.com/en-us/azure/sre-agent/
- **Container Apps:** https://learn.microsoft.com/azure/container-apps/
- **Application Insights:** https://learn.microsoft.com/azure/azure-monitor/app/app-insights-overview

---

## 🔧 Useful Commands

### View Resource Group Resources
```bash
az resource list --resource-group rg-octopets-sre-demo -o table
```

### Check Container App Status
```bash
az containerapp show --name octopetsapi --resource-group rg-octopets-sre-demo --query "properties.runningStatus" -o tsv
az containerapp show --name octopetsfe --resource-group rg-octopets-sre-demo --query "properties.runningStatus" -o tsv
```

### View Container App Logs
```bash
# Backend logs
az containerapp logs show --name octopetsapi --resource-group rg-octopets-sre-demo --follow

# Frontend logs
az containerapp logs show --name octopetsfe --resource-group rg-octopets-sre-demo --follow
```

### Restart Container Apps (To Clear Memory Leak)
```bash
az containerapp revision restart --name octopetsapi --resource-group rg-octopets-sre-demo
az containerapp revision restart --name octopetsfe --resource-group rg-octopets-sre-demo
```

### Clean Up Resources (When Done)
```bash
# Option 1: Delete just the resource group
az group delete --name rg-octopets-sre-demo --yes --no-wait

# Option 2: Use azd to clean up
cd /home/prwani_u/github_copilot/octopets/apphost
export PATH="$HOME/.dotnet:$PATH"
azd down
```

---

## 📝 Notes

### Limitations & Workarounds

1. **PagerDuty/ServiceNow Integration:**
   - Not configured (no account access)
   - Workaround: Use Azure Monitor Alerts or manual testing

2. **SRE Agent Portal Configuration:**
   - Some steps require Azure Portal access
   - Cannot be fully automated via CLI

3. **.NET SDK Installation:**
   - Installed at: `$HOME/.dotnet`
   - Added to PATH during deployment
   - Version: 9.0.310

### Security Considerations

- All resources use System Assigned Managed Identity where possible
- No hardcoded secrets or credentials in configuration
- Application Insights connection string is stored securely in Container App settings

### Cost Optimization

- Container Apps scale to zero when not in use
- Consider stopping resources when not actively testing
- Monitor costs in Azure Cost Management

---

## ✅ Deployment Verification

Run these checks to verify everything is working:

```bash
# 1. Check frontend is accessible
curl -s -o /dev/null -w "%{http_code}\n" https://octopetsfe.lemonbay-f7324bec.eastus2.azurecontainerapps.io/

# 2. Check backend API is accessible
curl -s -o /dev/null -w "%{http_code}\n" https://octopetsapi.lemonbay-f7324bec.eastus2.azurecontainerapps.io/api/products

# 3. Verify resource tags
az resource list --resource-group rg-octopets-sre-demo --query "[].{Name:name,Tags:tags}" -o table

# 4. Check Application Insights is receiving telemetry
az monitor app-insights query \
  --apps octopets_appinsights-w2shk6ckv6at4 \
  --resource-group rg-octopets-sre-demo \
  --analytics-query "requests | where timestamp > ago(5m) | summarize count()"
```

Expected Results:
- Frontend returns: `200`
- Backend returns: `200`
- All resources have the required tags
- Application Insights shows request telemetry

---

## 🆘 Troubleshooting

### Issue: Container App Not Starting

**Check revision status:**
```bash
az containerapp revision list --name octopetsapi --resource-group rg-octopets-sre-demo -o table
```

**View error logs:**
```bash
az containerapp logs show --name octopetsapi --resource-group rg-octopets-sre-demo --tail 50
```

### Issue: Frontend Can't Connect to Backend

**Verify environment variables:**
```bash
az containerapp show --name octopetsfe --resource-group rg-octopets-sre-demo --query "properties.template.containers[0].env" -o table
```

### Issue: No Telemetry in Application Insights

**Check connection string is set:**
```bash
az containerapp show --name octopetsapi --resource-group rg-octopets-sre-demo --query "properties.template.containers[0].env[?name=='APPLICATIONINSIGHTS_CONNECTION_STRING']" -o table
```

---

## 📧 Support & Feedback

- **GitHub Repository:** https://github.com/prwani/octopets-sre-demo
- **SRE Agent Repository:** https://github.com/microsoft/sre-agent
- **Azure Support:** https://azure.microsoft.com/support/

---

**Deployment completed by:** GitHub Copilot CLI  
**Deployment date:** January 31, 2026  
**Status:** ✅ All phases completed successfully
