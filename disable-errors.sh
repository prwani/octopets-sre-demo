#!/bin/bash
# disable-errors.sh - Disable error injection in Octopets to save costs

echo "🛑 Disabling error injection in octopetsapi..."
echo ""

az containerapp update \
  --name octopetsapi \
  --resource-group rg-octopets-sre-demo \
  --set-env-vars "Errors=false" \
  --query "properties.template.containers[0].env[?name=='ERRORS'].{Name:name,Value:value}" \
  -o table

echo ""
echo "✅ Error injection DISABLED"
echo ""
echo "Benefits:"
echo "  💰 Reduced CPU/memory usage"
echo "  💰 Lower Container Apps costs"
echo "  💰 Estimated savings: \$5-15/month"
echo ""
echo "To re-enable for testing, run: ./enable-errors.sh"
echo ""
