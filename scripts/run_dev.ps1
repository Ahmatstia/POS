# Lexa POS — run Widgetbook on a device/emulator.
# Fixes Flutter SDK git "dubious ownership" without changing global git config.

$ErrorActionPreference = "Stop"

$env:GIT_CONFIG_COUNT = "1"
$env:GIT_CONFIG_KEY_0 = "safe.directory"
$env:GIT_CONFIG_VALUE_0 = "C:/flutter"

$projectRoot = Split-Path -Parent $PSScriptRoot
Set-Location $projectRoot

Write-Host "Starting Lexa POS..." -ForegroundColor Cyan
flutter run

# Widgetbook catalog: flutter run -t lib/main_widgetbook.dart
