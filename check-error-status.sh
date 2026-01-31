#!/bin/bash
# check-error-status.sh - Check current error injection status

echo "🔍 Checking error injection status..."
echo ""

STATUS=$(az containerapp show \
  --name octopetsapi \
  --resource-group rg-octopets-sre-demo \
  --query "properties.template.containers[0].env[?name=='ERRORS'].value | [0]" \
  -o tsv 2>/dev/null)

if [ "$STATUS" == "true" ]; then
  echo "Status: 🔥 ENABLED (Error injection is active)"
  echo ""
  echo "Impact:"
  echo "  • Memory leak simulation: ACTIVE"
  echo "  • Will generate 500 errors after repeated use"
  echo "  • Higher CPU/memory usage = higher costs"
  echo ""
  echo "To disable: ./disable-errors.sh"
elif [ "$STATUS" == "false" ]; then
  echo "Status: ✅ DISABLED (Normal operation)"
  echo ""
  echo "Impact:"
  echo "  • No artificial errors generated"
  echo "  • Lower CPU/memory usage = lower costs"
  echo "  • App runs normally"
  echo ""
  echo "To enable for testing: ./enable-errors.sh"
else
  echo "Status: ⚠️  UNKNOWN (Could not determine status)"
  echo ""
  echo "This might mean:"
  echo "  • The ERRORS environment variable is not set"
  echo "  • Unable to connect to Azure"
  echo ""
  echo "Try running: az containerapp show -n octopetsapi -g rg-octopets-sre-demo"
fi

echo ""

# Show all environment variables for reference
echo "Current environment variables:"
az containerapp show \
  --name octopetsapi \
  --resource-group rg-octopets-sre-demo \
  --query "properties.template.containers[0].env[].{Name:name,Value:value}" \
  -o table 2>/dev/null

echo ""
