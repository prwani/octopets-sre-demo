#!/bin/bash
# trigger-errors-auto.sh - Automatically trigger memory leak errors by calling the API

echo "🔥 Triggering memory leak errors in octopetsapi..."
echo ""

BACKEND_URL="https://octopetsapi.lemonbay-f7324bec.eastus2.azurecontainerapps.io"
FRONTEND_URL="https://octopetsfe.lemonbay-f7324bec.eastus2.azurecontainerapps.io"

echo "📍 Backend API: $BACKEND_URL"
echo ""

# First, wake up the frontend (scales from zero)
echo "1. Waking up frontend..."
curl -s -o /dev/null -w "Status: %{http_code}\n" "$FRONTEND_URL"
sleep 2

# Now trigger the memory leak by calling the listing detail endpoint 5 times
# This simulates clicking "View Details" 5 times
echo ""
echo "2. Triggering memory leak (5 requests to /api/listings/{id})..."
echo ""

for i in {1..5}; do
  echo "   Request $i/5: GET /api/listings/$i"
  
  RESPONSE=$(curl -s -w "\n%{http_code}" "$BACKEND_URL/api/listings/$i")
  HTTP_CODE=$(echo "$RESPONSE" | tail -n 1)
  
  if [ "$HTTP_CODE" == "200" ]; then
    echo "   ✅ Success (HTTP $HTTP_CODE) - Memory allocated"
  elif [ "$HTTP_CODE" == "404" ]; then
    echo "   ⚠️  Not Found (HTTP $HTTP_CODE) - Trying next ID"
  else
    echo "   🔴 Error (HTTP $HTTP_CODE) - Memory leak may be causing failures"
  fi
  
  # Small delay between requests
  sleep 1
done

echo ""
echo "✅ Completed 5 requests"
echo ""
echo "⏳ Waiting 2-3 minutes for errors to accumulate..."
echo "   (Memory leak effect takes a moment to manifest)"
echo ""
echo "🔍 Check Application Insights for errors:"
echo "   Azure Portal → rg-octopets-sre-demo → octopets_appinsights-w2shk6ckv6at4"
echo ""
echo "🤖 Test SRE Agent diagnosis:"
echo "   Go to Playground and ask: 'check octopetsapi for errors in the last 10 minutes'"
echo ""
