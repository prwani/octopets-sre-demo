#!/bin/bash
# enable-errors.sh - Enable error injection in Octopets for testing

echo "🔥 Enabling error injection in octopetsapi..."
echo ""

az containerapp update \
  --name octopetsapi \
  --resource-group rg-octopets-sre-demo \
  --set-env-vars "Errors=true" \
  --query "properties.template.containers[0].env[?name=='ERRORS'].{Name:name,Value:value}" \
  -o table

echo ""
echo "✅ Error injection ENABLED"
echo ""
echo "What this does:"
echo "  🐛 Activates memory leak simulation"
echo "  🔴 Backend will throw 500 errors after 5x 'View Details' clicks"
echo "  📊 Great for testing SRE Agent diagnostics"
echo ""
echo "To trigger errors:"
echo "  1. Open: https://octopetsfe.lemonbay-f7324bec.eastus2.azurecontainerapps.io"
echo "  2. Click 'Browse Listings' → Select product → 'View Details'"
echo "  3. Repeat step 2 FIVE times"
echo "  4. Wait 2-3 minutes for errors to accumulate"
echo ""
echo "To disable when done testing, run: ./disable-errors.sh"
echo ""
