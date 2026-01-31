# Automated Error Triggering

This directory contains automation to trigger errors daily for SRE Agent testing.

## 📋 What's Included

1. **trigger-errors-auto.sh** - Bash script to trigger errors on demand
2. **daily-error-trigger.yml** - GitHub Actions workflow for daily automation

---

## 🔧 Manual Trigger (Run Anytime)

Use the bash script to trigger errors manually:

```bash
cd /home/prwani_u/github_copilot/octopets
./trigger-errors-auto.sh
```

**What it does:**
- Calls the backend API 5 times (simulates clicking "View Details")
- Each call allocates 1GB memory (memory leak)
- Waits between requests
- Shows success/failure status
- Takes ~15-20 seconds to complete

---

## ⏰ Automated Daily Trigger (GitHub Actions)

### How It Works

A GitHub Actions workflow runs **automatically at 5:00 AM UTC every day** and triggers the memory leak errors.

**Schedule:** 5:00 AM UTC = 
- 12:00 AM EST (Eastern US)
- 10:30 AM IST (India)
- Adjust as needed

### Setup Instructions

The workflow is already in your repository at:
`.github/workflows/daily-error-trigger.yml`

**To activate:**
1. Push the workflow file to GitHub (done automatically)
2. Go to: https://github.com/prwani/octopets-sre-demo/actions
3. Find "Daily Error Trigger for SRE Agent Testing"
4. The workflow will run automatically starting tomorrow at 5 AM UTC

**To test manually (don't wait for 5 AM):**
1. Go to: https://github.com/prwani/octopets-sre-demo/actions
2. Click "Daily Error Trigger for SRE Agent Testing"
3. Click "Run workflow" button
4. Select branch: `main`
5. Click "Run workflow"
6. Watch it execute in real-time!

### What the Workflow Does

```
5:00 AM UTC Daily:
├─ 1. Wakes up the frontend (scales from 0)
├─ 2. Calls /api/listings/{id} 5 times (triggers memory leak)
├─ 3. Waits between requests
└─ 4. Shows summary and next run time
```

**Result:**
- Memory leak triggered automatically
- Errors appear in Application Insights
- SRE Agent can detect and diagnose
- Your daily health check (8 AM) will find the anomalies!

---

## ⏱️ Timeline (Your Current Setup)

**Daily Automation Schedule:**

```
5:00 AM UTC - GitHub Actions triggers errors
              └─ 5 API calls
              └─ Memory leak activated
              └─ Takes ~20 seconds

5:05 AM UTC - Errors accumulate in Application Insights
              └─ 500 errors logged
              └─ Memory metrics spike
              └─ Container App slows down

8:00 AM UTC - SRE Agent health check runs
              └─ Detects anomalies from 3 hours ago
              └─ Analyzes the errors
              └─ Creates report in Activities
              └─ (Would send email if Outlook connected)
```

**Perfect testing setup!** Errors are generated at 5 AM, then the health check at 8 AM finds them!

---

## 🎯 Use Cases

### Use Case 1: Daily SRE Agent Testing
- Keep both automations running
- Errors at 5 AM, health check at 8 AM
- Test agent's detection capabilities daily
- Cost: ~$10-20/month extra

### Use Case 2: Weekly Testing
Edit the cron schedule to weekly:
```yaml
schedule:
  - cron: '0 5 * * 1'  # Every Monday at 5 AM
```

### Use Case 3: On-Demand Only
- Disable the GitHub Actions workflow
- Run `./trigger-errors-auto.sh` manually when needed
- Cost: Only when you run it

---

## 🛑 Disable Automation

### Disable Daily Error Trigger

**Option 1: Disable in GitHub UI**
1. Go to: https://github.com/prwani/octopets-sre-demo/actions
2. Click "Daily Error Trigger for SRE Agent Testing"
3. Click "..." menu → "Disable workflow"

**Option 2: Delete the workflow file**
```bash
git rm .github/workflows/daily-error-trigger.yml
git commit -m "Disable daily error trigger"
git push
```

**Option 3: Comment out the schedule**
Edit `.github/workflows/daily-error-trigger.yml`:
```yaml
on:
  # schedule:
  #   - cron: '0 5 * * *'
  workflow_dispatch:  # Keep manual trigger
```

### Disable Daily Health Check

In SRE Agent Portal:
1. Go to "Scheduled Tasks"
2. Find "Daily Octopets Health Check"
3. Click "..." → "Pause" or "Delete"

---

## 💰 Cost Impact

**With Daily Automation:**
- Error trigger (5 AM): ~$0.05-0.10/day (minimal)
- Health check (8 AM): ~$0.10-0.50/day
- Apps running: ~$0.15-0.60/day
- **Total: ~$5-20/month** for automation

**Without Automation:**
- Only pay when manually triggered
- Or when someone accesses the app
- Idle cost: ~$5-10/month

---

## 🧪 Testing

### Test the Script Locally

```bash
cd /home/prwani_u/github_copilot/octopets
./trigger-errors-auto.sh
```

Watch the output - should see 5 successful API calls.

### Test the GitHub Action

1. Go to: https://github.com/prwani/octopets-sre-demo/actions
2. Click "Daily Error Trigger for SRE Agent Testing"
3. Click "Run workflow"
4. Watch the workflow execute
5. Check the logs for output

### Verify Errors Were Created

After triggering (manual or automated):

1. Wait 2-3 minutes
2. Go to Application Insights
3. Check Failures tab for 500 errors
4. Run SRE Agent diagnosis in Playground

---

## 📚 Additional Resources

- **Main setup guide:** `../SRE_AGENT_COMPLETE_SETUP.md`
- **Error control scripts:** `../enable-errors.sh`, `../disable-errors.sh`
- **GitHub Actions docs:** https://docs.github.com/en/actions

---

**Next Run:** Tomorrow at 5:00 AM UTC (after you push this to GitHub)

**Manual Test:** Run `./trigger-errors-auto.sh` anytime!
