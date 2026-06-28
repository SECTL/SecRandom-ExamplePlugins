# SecRandom Example Plugins

This repository contains buildable example plugins for SecRandom.

## Build

```powershell
$env:SECRANDOM_CORE_DLL = "D:\code\SecRandom-C\SecRandom.Core\bin\Release\net10.0\SecRandom.Core.dll"
dotnet build ExamplePlugin/SecRandom.ExamplePlugin.csproj -c Release /p:SecRandomCoreDll="$env:SECRANDOM_CORE_DLL"
.\scripts\package-example.ps1 -SecRandomCoreDll "$env:SECRANDOM_CORE_DLL"
```

The package is written to `artifacts/com.example.plugin-1.0.0.srpx`.
