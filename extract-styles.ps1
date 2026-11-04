# PowerShell script to extract all inline styles from HTML and save to external CSS file

$htmlFile = "c:\Users\ADMIN\Downloads\sLY\SITES\dstv\index.html"
$cssFile = "c:\Users\ADMIN\Downloads\sLY\SITES\dstv\embedded-styles.css"

# Read the HTML file
$content = Get-Content $htmlFile -Raw

# Extract all <style> tags content
$matches = [regex]::Matches($content, '<style>(.*?)</style>', [System.Text.RegularExpressions.RegexOptions]::Singleline)

Write-Host "Found $($matches.Count) style tags"

# Combine all styles into one CSS file
$allStyles = ""
foreach ($match in $matches) {
    $styleContent = $match.Groups[1].Value
    $allStyles += $styleContent + "`n`n"
}

# Save to CSS file
$allStyles | Set-Content $cssFile -Encoding UTF8

Write-Host "Extracted styles saved to $cssFile"
Write-Host "Total style content length: $($allStyles.Length) characters"

# Now remove all <style> tags from HTML
$newContent = [regex]::Replace($content, '<style>.*?</style>', '', [System.Text.RegularExpressions.RegexOptions]::Singleline)

# Save the cleaned HTML
$newContent | Set-Content $htmlFile -Encoding UTF8

Write-Host "Removed all <style> tags from HTML"
