# Example 1: Creating a hashtable (which can be easily converted to JSON)

$postData = @{
    "title"   = "New DNS Record Detected"
    "domain"  = "example.com"
    "recordType" = "A"
    "previousRecords" = @(
        "192.168.1.1",
        "10.0.0.1"
    )
    "newRecords" = @(
        "192.168.1.2",
        "10.0.0.2"
    )
    "timestamp" = Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ" # ISO 8601 format
    "alertLevel" = "High"
}

# Convert to JSON:
$jsonPayload = $postData | ConvertTo-Json -Depth 3  # -Depth is important for nested objects/arrays

# Example 2:  Creating JSON directly (less flexible for variable substitution)

$jsonPayloadDirect = @"
{
    "title": "New DNS Record Detected",
    "domain": "example.com",
    "recordType": "A",
    "previousRecords": [
        "192.168.1.1",
        "10.0.0.1"
    ],
    "newRecords": [
        "192.168.1.2",
        "10.0.0.2"
    ],
    "timestamp": "$(Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ")",  # Variable substitution here
    "alertLevel": "High"
}
"@

# Example 3: Using a here-string for more complex JSON (with variable substitution)

$domain = "another-example.net"
$alertLevel = "Medium"

$jsonPayloadHereString = @"
{
  "title": "DNS Change Detected",
  "domain": "$domain",  # Variable substitution
  "details": {
    "previous": [ "1.1.1.1" ],
    "current": [ "8.8.8.8" ]
  },
  "alert": "$alertLevel" # Variable Substitution
}
"@


# --- How to use the JSON payload in a POST request ---

# Example using Invoke-RestMethod (for simple POST requests):

Invoke-RestMethod -Uri "https://your-api.com/endpoint" -Method Post -Body $jsonPayload -ContentType "application/json"


# Example using Invoke-WebRequest (for more control):

$headers = @{
    "Content-Type" = "application/json"
}

Invoke-WebRequest -Uri "https://your-api.com/endpoint" -Method Post -Body $jsonPayload -Headers $headers


# --- Displaying the JSON ---

# To see the JSON output:
Write-Host $jsonPayload
Write-Host $jsonPayloadDirect
Write-Host $jsonPayloadHereString