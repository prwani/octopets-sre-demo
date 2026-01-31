# SRE Agent Portal Configuration Guide

## ⚠️ IMPORTANT: These steps require Azure Portal access

Since Azure SRE Agent management features don't have Azure CLI equivalents yet, you'll need to complete these steps in the Azure Portal. This guide provides **exact copy-paste values** to make it as quick as possible.

---

## 🔗 Access the SRE Agent Portal

**Direct Link:**
https://ms.portal.azure.com/#view/Microsoft_Azure_PaasServerless/AgentFrameBlade.ReactView/id/%2Fsubscriptions%2F23835f6b-9ad7-4c33-b0b8-55157ad0d2b5%2FresourceGroups%2Frg-sre-agent-demo%2Fproviders%2FMicrosoft.App%2Fagents%2Foctopets-sre-agent

**Bookmark this link** for quick access!

---

## Step 2: Connect GitHub Repository to Container Apps

### What This Does
Links your GitHub repository to the Container Apps so the SRE Agent can perform code analysis and create issues.

### Instructions

1. In the SRE Agent portal, click **"Resource Mapping"** tab

2. You should see these resources listed:
   - `octopetsapi` (Container App)
   - `octopetsfe` (Container App)

3. For **octopetsapi**:
   - Click **"Connect Repository"** button on the right
   - In the dialog, enter:
     ```
     https://github.com/prwani/octopets-sre-demo
     ```
   - Click **"Authorize"**
   - Complete GitHub authorization if prompted
   - Verify status shows **"Connected"** ✅

4. For **octopetsfe**:
   - Repeat the same process
   - Enter the same repository URL:
     ```
     https://github.com/prwani/octopets-sre-demo
     ```
   - Click **"Authorize"**
   - Verify status shows **"Connected"** ✅

### Verification
Both `octopetsapi` and `octopetsfe` should show:
- Status: **Connected**
- Repository: **prwani/octopets-sre-demo**

---

## Step 3: Create Incident Automation Subagent

### What This Does
Creates an intelligent agent that automatically diagnoses errors, analyzes code, and creates GitHub issues with root cause analysis.

### Instructions

1. In the SRE Agent portal, click **"Subagent Builder"** tab

2. Click **"+ New Subagent"** button

3. Enter the following details:
   - **Name:** (copy-paste)
     ```
     AzureResourceErrorHandler
     ```
   - **Description:** (copy-paste)
     ```
     Handles Azure Container App errors and performs root cause analysis
     ```

4. Click **"Create"**

5. After creation, click on **"AzureResourceErrorHandler"** to open it

6. Click **"Edit"** button

7. Click the **"YAML"** tab

8. **Delete all existing content** in the YAML editor

9. Copy the YAML from this file:
   `/home/prwani_u/github_copilot/sre-agent-config/incident-handler-customized.yaml`
   
   (I'll create this file with your specific values in the next step)

10. Paste the YAML into the editor

11. Click **"Save"**

### What the Agent Will Do
- Automatically diagnose Container App errors
- Analyze logs and metrics in Application Insights
- Perform semantic code search in your GitHub repo
- Create detailed GitHub issues with:
  - Root cause analysis
  - Proposed code fixes
  - Evidence from logs/metrics
  - Links to relevant code

---

## Step 4: Create Health Check Subagent

### What This Does
Creates an agent that performs daily health checks on your Container Apps and sends email alerts only if anomalies are detected.

### Instructions

1. In the SRE Agent portal, go to **"Subagent Builder"** tab

2. Click **"+ New Subagent"** button

3. Enter the following details:
   - **Name:** (copy-paste)
     ```
     HealthCheckAgent
     ```
   - **Description:** (copy-paste)
     ```
     Performs daily health checks on Octopets Container Apps
     ```

4. Click **"Create"**

5. After creation, click on **"HealthCheckAgent"** to open it

6. Click **"Edit"** button

7. Click the **"YAML"** tab

8. **Delete all existing content** in the YAML editor

9. Copy the YAML from this file:
   `/home/prwani_u/github_copilot/sre-agent-config/health-check-customized.yaml`
   
   (I'll create this file with your specific values in the next step)

10. Paste the YAML into the editor

11. Click **"Save"**

### What the Agent Will Do
- Check CPU, memory, and error rates every day
- Analyze metrics from the last 24 hours
- Detect anomalies using statistical analysis
- Send email alerts ONLY if problems are found
- No email if everything is healthy

---

## Step 5: Set Up Scheduled Health Check

### What This Does
Schedules the Health Check Agent to run automatically every day at 8:00 AM.

### Instructions

1. In the SRE Agent portal, go to **"Scheduled Tasks"** tab

2. Click **"+ New Scheduled Task"** button

3. Fill in the form with these values:

   **Task Name:** (copy-paste)
   ```
   Daily Octopets Health Check
   ```

   **Response Subagent:** (select from dropdown)
   ```
   HealthCheckAgent
   ```

   **Task Details:** (copy-paste)
   ```
   check health of octopetsapi and octopetsfe container apps in resource group rg-octopets-sre-demo with subscription ID 23835f6b-9ad7-4c33-b0b8-55157ad0d2b5
   ```

   **Frequency:** (select from dropdown)
   ```
   Daily
   ```

   **Time:** (enter)
   ```
   08:00
   ```
   
   **Time Zone:** (select)
   ```
   (UTC) Coordinated Universal Time
   ```

   **Start Date:** (select)
   ```
   [Select today's date or tomorrow]
   ```

   **Message Grouping for Updates:** (select from dropdown)
   ```
   New thread for each run
   ```

4. Click **"Save"**

### Verification
- Check that the task appears in the Scheduled Tasks list
- Status should be **"Active"**
- Next run time should be displayed

### To Test Immediately (Optional)
1. Find your task in the list
2. Click **"Run Now"** button
3. Go to **"Activities"** tab to see the execution
4. Check your email for the health report (if anomalies were found)

---

## Step 6: Test the Incident Handler (Optional)

### What This Does
Verifies that the Incident Handler subagent can access your Azure resources and GitHub repo.

### Instructions

1. Go to **"Subagent Builder"** tab

2. Click on **"AzureResourceErrorHandler"**

3. Click **"Playground"** button

4. Click **"2 Window View"** to split the interface

5. In the chat input, enter this test prompt: (copy-paste)
   ```
   container app octopetsapi in resource group rg-octopets-sre-demo with subscription ID 23835f6b-9ad7-4c33-b0b8-55157ad0d2b5 is experiencing errors, can you troubleshoot and find root cause, skip getting info from pagerduty and proceed
   ```

6. Press **Enter** and watch the agent work

### What to Expect
The agent should:
- ✅ Acknowledge the request
- ✅ Query Application Insights for logs and metrics
- ✅ Analyze error patterns
- ✅ Search your GitHub repository for related code
- ✅ Provide a diagnosis with evidence
- ✅ (Optional) Create a GitHub issue

If it asks for clarification, provide the requested information.

### Troubleshooting
- **"Cannot access resource"**: Check that the SRE Agent has permissions (should be automatic from Bicep deployment)
- **"Cannot access GitHub repo"**: Complete Step 2 (Resource Mapping)
- **Agent doesn't respond**: Refresh the page and try again

---

## 📋 Quick Checklist

Before you start, verify:
- [ ] Azure Portal access
- [ ] You're logged into the correct subscription: `23835f6b-9ad7-4c33-b0b8-55157ad0d2b5`
- [ ] SRE Agent portal link works (see top of document)
- [ ] You have the customized YAML files ready

After completing all steps:
- [ ] Step 2: GitHub repository connected to both Container Apps ✅
- [ ] Step 3: AzureResourceErrorHandler subagent created with YAML ✅
- [ ] Step 4: HealthCheckAgent subagent created with YAML ✅
- [ ] Step 5: Daily health check scheduled for 8:00 AM ✅
- [ ] Step 6 (Optional): Tested incident handler in Playground ✅

---

## 🆘 Need Help?

**Common Issues:**

1. **"Cannot find Subagent Builder"**
   - Make sure you're in the SRE Agent portal (link at top)
   - Look for tabs: Overview, Resource Mapping, Subagent Builder, Scheduled Tasks, Activities

2. **"GitHub authorization fails"**
   - Ensure you're logged into GitHub as `prwani`
   - Check that the repository exists: https://github.com/prwani/octopets-sre-demo
   - Try refreshing the page and re-authorizing

3. **"YAML validation error"**
   - Make sure you copied the entire YAML file
   - Check that there are no extra spaces at the beginning
   - Verify the email address was updated (if applicable)

4. **"Scheduled task not running"**
   - Check the Status is "Active"
   - Verify the time zone is correct
   - Try "Run Now" to test immediately

**Resources:**
- Complete deployment info: `/home/prwani_u/github_copilot/SRE_AGENT_COMPLETE_SETUP.md`
- SRE Agent documentation: https://learn.microsoft.com/en-us/azure/sre-agent/

---

## ⏱️ Estimated Time

- Step 2 (GitHub connection): **3 minutes**
- Step 3 (Incident handler): **5 minutes**
- Step 4 (Health check): **5 minutes**
- Step 5 (Schedule task): **3 minutes**
- Step 6 (Testing): **5 minutes** (optional)

**Total: ~15-20 minutes**

---

**Ready to start?** Open the SRE Agent portal link at the top and begin with Step 2!
