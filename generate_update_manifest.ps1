param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^\d+\.\d+\.\d+$')]
    [string]$Version,

    [Parameter(Mandatory = $true)]
    [ValidateScript({ Test-Path -LiteralPath $_ -PathType Leaf })]
    [string]$InstallerPath,

    [Parameter(Mandatory = $true)]
    [string]$ReleaseNotes,

    [string]$OutputPath = (Join-Path (Get-Location) 'update_manifest.json')
)

$ErrorActionPreference = 'Stop'
$installer = Get-Item -LiteralPath $InstallerPath
if ($installer.Extension -ine '.exe') {
    throw 'InstallerPath must point to a Windows .exe installer.'
}
if ($installer.Length -le 0) {
    throw 'Installer file is empty.'
}

$tag = "v$Version"
$assetName = $installer.Name
$escapedAssetName = [Uri]::EscapeDataString($assetName)
$installerUrl = "https://github.com/K-A-G/HyperPDF-Updates/releases/download/$tag/$escapedAssetName"
$sha256 = (Get-FileHash -LiteralPath $installer.FullName -Algorithm SHA256).Hash.ToLowerInvariant()

$manifest = [ordered]@{
    version       = $Version
    published_at  = (Get-Date).ToString('yyyy-MM-dd')
    release_notes = $ReleaseNotes
    installer_url = $installerUrl
    sha256        = $sha256
}

$json = $manifest | ConvertTo-Json -Depth 4
$destination = [System.IO.Path]::GetFullPath($OutputPath)
$directory = [System.IO.Path]::GetDirectoryName($destination)
if ($directory -and -not (Test-Path -LiteralPath $directory)) {
    New-Item -ItemType Directory -Path $directory -Force | Out-Null
}
# UTF-8 with BOM is accepted by HyperPDF's utf-8-sig JSON reader.
Set-Content -LiteralPath $destination -Value $json -Encoding UTF8
Write-Host "Manifest created: $destination"
Write-Host "Version:         $Version"
Write-Host "Installer URL:   $installerUrl"
Write-Host "SHA-256:         $sha256"
Write-Host ''
Write-Host 'Publish order: upload the installer to the matching GitHub Release first,' -ForegroundColor Yellow
Write-Host 'then commit update_manifest.json to the repository main branch.' -ForegroundColor Yellow
