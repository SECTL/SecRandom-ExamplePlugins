param(
    [string]$SecRandomCoreDll = $env:SECRANDOM_CORE_DLL
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$project = Join-Path $repoRoot "ExamplePlugin/SecRandom.ExamplePlugin.csproj"
$output = Join-Path $repoRoot "artifacts/package/com.example.plugin"
$packageDirectory = Join-Path $repoRoot "packages"
$package = Join-Path $packageDirectory "com.example.plugin-1.0.0.srpx"
$zipPackage = Join-Path $packageDirectory "com.example.plugin-1.0.0.zip"

if ([string]::IsNullOrWhiteSpace($SecRandomCoreDll)) {
    $candidate = "D:\code\SecRandom-C\SecRandom.Core\bin\Release\net10.0\SecRandom.Core.dll"
    if (Test-Path $candidate) {
        $SecRandomCoreDll = $candidate
    }
}

if ([string]::IsNullOrWhiteSpace($SecRandomCoreDll) -or -not (Test-Path $SecRandomCoreDll)) {
    throw "SecRandom.Core.dll not found. Pass -SecRandomCoreDll or set SECRANDOM_CORE_DLL."
}

if (Test-Path $output) {
    Remove-Item -LiteralPath $output -Recurse -Force
}

New-Item -ItemType Directory -Path $output | Out-Null
New-Item -ItemType Directory -Path $packageDirectory | Out-Null
dotnet publish $project -c Release -o $output --no-self-contained /p:SecRandomCoreDll="$SecRandomCoreDll"
Copy-Item -LiteralPath (Join-Path $repoRoot "ExamplePlugin/plugin.json") -Destination (Join-Path $output "plugin.json") -Force

if (Test-Path $package) {
    Remove-Item -LiteralPath $package -Force
}

if (Test-Path $zipPackage) {
    Remove-Item -LiteralPath $zipPackage -Force
}

Compress-Archive -Path (Join-Path $output "*") -DestinationPath $zipPackage -Force
Move-Item -LiteralPath $zipPackage -Destination $package -Force
Write-Host $package
