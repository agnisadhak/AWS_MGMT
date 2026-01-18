# AWS Cost Analysis Script
# This script retrieves and displays your AWS billing information

param(
    [switch]$Detailed,
    [int]$Days = 7
)

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "   AWS Cost Analysis Report" -ForegroundColor Cyan
Write-Host "======================================`n" -ForegroundColor Cyan

# Get current date
$endDate = (Get-Date).ToString("yyyy-MM-dd")
$startDate = (Get-Date).AddDays(-$Days).ToString("yyyy-MM-dd")
$monthStart = (Get-Date -Day 1).ToString("yyyy-MM-dd")

Write-Host "📅 Analysis Period: $startDate to $endDate`n" -ForegroundColor Yellow

# 1. Get Month-to-Date Total Cost
Write-Host "💰 MONTH-TO-DATE COSTS" -ForegroundColor Green
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Green

$timePeriod = "Start=$monthStart,End=$endDate"
$mtdCost = aws ce get-cost-and-usage `
    --time-period $timePeriod `
    --granularity MONTHLY `
    --metrics UnblendedCost `
    --output json `
    --no-cli-pager | ConvertFrom-Json

$totalCost = [math]::Round([decimal]$mtdCost.ResultsByTime[0].Total.UnblendedCost.Amount, 2)
Write-Host "Total MTD Cost: `$$totalCost USD" -ForegroundColor White

# 2. Get Cost Forecast
Write-Host "`n📊 COST FORECAST" -ForegroundColor Green
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Green

$nextMonth = (Get-Date).AddMonths(1).ToString("yyyy-MM-01")
$forecastPeriod = "Start=$endDate,End=$nextMonth"
$forecast = aws ce get-cost-forecast `
    --time-period $forecastPeriod `
    --metric BLENDED_COST `
    --granularity MONTHLY `
    --output json `
    --no-cli-pager | ConvertFrom-Json

$forecastAmount = [math]::Round([decimal]$forecast.Total.Amount, 2)
Write-Host "Forecasted Monthly Cost: `$$forecastAmount USD" -ForegroundColor White

# 3. Get Cost by Service (MTD)
Write-Host "`n🔧 TOP SERVICES BY COST (Month-to-Date)" -ForegroundColor Green
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Green

$servicesCost = aws ce get-cost-and-usage `
    --time-period $timePeriod `
    --granularity MONTHLY `
    --metrics UnblendedCost `
    --group-by Type=DIMENSION, Key=SERVICE `
    --output json `
    --no-cli-pager | ConvertFrom-Json

$services = $servicesCost.ResultsByTime[0].Groups | 
ForEach-Object {
    [PSCustomObject]@{
        Service = $_.Keys[0]
        Cost    = [decimal]$_.Metrics.UnblendedCost.Amount
    }
} |
Where-Object { $_.Cost -ne 0 } |
Sort-Object Cost -Descending |
Select-Object -First 10

$i = 1
foreach ($service in $services) {
    $costStr = "`$$([math]::Round($service.Cost, 4))"
    Write-Host "$i. $($service.Service.PadRight(50)) $costStr" -ForegroundColor White
    $i++
}

# 4. Get Daily Cost Trend (Last 7 days)
if ($Detailed) {
    Write-Host "`n📈 DAILY COST TREND (Last $Days Days)" -ForegroundColor Green
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Green

    $dailyPeriod = "Start=$startDate,End=$endDate"
    $dailyCosts = aws ce get-cost-and-usage `
        --time-period $dailyPeriod `
        --granularity DAILY `
        --metrics UnblendedCost `
        --output json `
        --no-cli-pager | ConvertFrom-Json

    foreach ($day in $dailyCosts.ResultsByTime) {
        $date = $day.TimePeriod.Start
        $cost = [math]::Round([decimal]$day.Total.UnblendedCost.Amount, 2)
        Write-Host "$date : `$$cost" -ForegroundColor White
    }
}

# 5. Get Anomalies (if available)
Write-Host "`n⚠️  COST ANOMALY DETECTION" -ForegroundColor Green
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Green

try {
    $anomalyPeriod = "StartDate=$startDate,EndDate=$endDate"
    $anomalies = aws ce get-anomalies `
        --date-interval $anomalyPeriod `
        --output json `
        --no-cli-pager 2>&1 | ConvertFrom-Json

    if ($anomalies.Anomalies.Count -gt 0) {
        Write-Host "Found $($anomalies.Anomalies.Count) anomalies:" -ForegroundColor Yellow
        foreach ($anomaly in $anomalies.Anomalies) {
            Write-Host "  - $($anomaly.RootCauses[0].Service): Impact `$$([math]::Round([decimal]$anomaly.Impact.TotalImpact, 2))" -ForegroundColor Yellow
        }
    }
    else {
        Write-Host "No cost anomalies detected" -ForegroundColor White
    }
}
catch {
    Write-Host "Anomaly detection not available or no anomalies found" -ForegroundColor Gray
}

# 6. Previous Month Comparison
Write-Host "`n📊 PREVIOUS MONTH COMPARISON" -ForegroundColor Green
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Green

$prevMonthStart = (Get-Date -Day 1).AddMonths(-1).ToString("yyyy-MM-dd")
$prevMonthEnd = (Get-Date -Day 1).AddDays(-1).ToString("yyyy-MM-dd")

$prevPeriod = "Start=$prevMonthStart,End=$prevMonthEnd"
$prevMonthCost = aws ce get-cost-and-usage `
    --time-period $prevPeriod `
    --granularity MONTHLY `
    --metrics UnblendedCost `
    --output json `
    --no-cli-pager | ConvertFrom-Json

$prevCost = [math]::Round([decimal]$prevMonthCost.ResultsByTime[0].Total.UnblendedCost.Amount, 2)
Write-Host "Previous Month Total: `$$prevCost USD" -ForegroundColor White

if ($prevCost -gt 0) {
    $change = [math]::Round((($totalCost - $prevCost) / $prevCost) * 100, 2)
    if ($change -gt 0) {
        Write-Host "Change: +$change% (Increased)" -ForegroundColor Red
    }
    elseif ($change -lt 0) {
        Write-Host "Change: $change% (Decreased)" -ForegroundColor Green
    }
    else {
        Write-Host "Change: No change" -ForegroundColor White
    }
}

Write-Host "`n======================================" -ForegroundColor Cyan
Write-Host "Report generated on: $(Get-Date)" -ForegroundColor Gray
Write-Host "======================================`n" -ForegroundColor Cyan

# Usage Examples
Write-Host "`n💡 USAGE TIPS:" -ForegroundColor Magenta
Write-Host "  - Run with -Detailed flag for daily breakdown: .\check-aws-costs.ps1 -Detailed" -ForegroundColor Gray
Write-Host "  - Specify custom days: .\check-aws-costs.ps1 -Days 30" -ForegroundColor Gray
Write-Host "  - Export to file: .\check-aws-costs.ps1 | Out-File aws-costs-report.txt`n" -ForegroundColor Gray
