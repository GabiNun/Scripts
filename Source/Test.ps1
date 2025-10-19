#ai slop hope this works

#Requires -RunAsAdministrator
<#
.SYNOPSIS
    Complete Microsoft Edge unregistration script for Windows 11
.DESCRIPTION
    Removes all Edge registry entries, file associations, protocol handlers,
    and system integrations while preserving system stability.
.NOTES
    WARNING: This script performs deep system modifications. Use at your own risk.
    Requires Administrator privileges.
    Based on Chromium uninstaller patterns.
#>

# Color output functions
function Write-Success { Write-Host $args -ForegroundColor Green }
function Write-Info { Write-Host $args -ForegroundColor Cyan }
function Write-Warn { Write-Host $args -ForegroundColor Yellow }
function Write-Fail { Write-Host $args -ForegroundColor Red }

# Error handling
$ErrorActionPreference = "Continue"

Write-Info "=========================================="
Write-Info "Microsoft Edge Unregistration Script"
Write-Info "=========================================="
Write-Warn "`nWARNING: This will completely unregister Edge from Windows."
Write-Warn "Some Windows features may be affected."
$confirmation = Read-Host "`nDo you want to continue? (yes/no)"
if ($confirmation -ne "yes") {
    Write-Info "Operation cancelled."
    exit
}

# Edge paths and identifiers
$edgePaths = @(
    "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
    "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe"
)

$edgeProgIds = @(
    "MSEdgeHTM",
    "MSEdgePDF",
    "MSEdgeMHT"
)

$edgeAppIds = @(
    "MSEdge",
    "Microsoft Edge"
)

# Protocol associations
$protocols = @(
    "http", "https", "ftp", "mailto", "news", "nntp",
    "snews", "telnet", "wais", "file", "ms-help",
    "ms-settings", "microsoft-edge"
)

# File associations
$fileAssociations = @(
    ".htm", ".html", ".pdf", ".shtml", ".svg",
    ".webp", ".xht", ".xhtml", ".mht", ".mhtml"
)

Write-Info "`n[1/10] Stopping Edge processes..."
try {
    Get-Process -Name "msedge", "MicrosoftEdge*", "edge*" -ErrorAction SilentlyContinue | Stop-Process -Force
    Start-Sleep -Seconds 2
    Write-Success "Edge processes terminated."
} catch {
    Write-Warn "Could not stop all Edge processes: $_"
}

Write-Info "`n[2/10] Removing HKLM ProgID registrations..."
foreach ($progId in $edgeProgIds) {
    try {
        $progIdPath = "HKLM:\SOFTWARE\Classes\$progId"
        if (Test-Path $progIdPath) {
            Remove-Item -Path $progIdPath -Recurse -Force -ErrorAction Stop
            Write-Success "Removed $progId from HKLM"
        }
        
        # Also remove from Wow6432Node
        $progIdPathWow = "HKLM:\SOFTWARE\Wow6432Node\Classes\$progId"
        if (Test-Path $progIdPathWow) {
            Remove-Item -Path $progIdPathWow -Recurse -Force -ErrorAction Stop
        }
    } catch {
        Write-Warn "Failed to remove $progId : $_"
    }
}

Write-Info "`n[3/10] Removing HKCU ProgID registrations..."
foreach ($progId in $edgeProgIds) {
    try {
        $progIdPath = "HKCU:\SOFTWARE\Classes\$progId"
        if (Test-Path $progIdPath) {
            Remove-Item -Path $progIdPath -Recurse -Force -ErrorAction Stop
            Write-Success "Removed $progId from HKCU"
        }
    } catch {
        Write-Warn "Failed to remove $progId from HKCU: $_"
    }
}

Write-Info "`n[4/10] Clearing StartMenuInternet registrations..."
$startMenuPath = "HKLM:\SOFTWARE\Clients\StartMenuInternet"
try {
    $edgeKeys = Get-ChildItem -Path $startMenuPath -ErrorAction SilentlyContinue | 
                Where-Object { $_.PSChildName -like "*Edge*" -or $_.PSChildName -like "*MSEdge*" }
    
    foreach ($key in $edgeKeys) {
        Remove-Item -Path $key.PSPath -Recurse -Force -ErrorAction Stop
        Write-Success "Removed $($key.PSChildName) from StartMenuInternet"
    }
} catch {
    Write-Warn "Failed to clean StartMenuInternet: $_"
}

# Also clean HKCU
$startMenuPathUser = "HKCU:\SOFTWARE\Clients\StartMenuInternet"
try {
    if (Test-Path $startMenuPathUser) {
        $edgeKeysUser = Get-ChildItem -Path $startMenuPathUser -ErrorAction SilentlyContinue | 
                        Where-Object { $_.PSChildName -like "*Edge*" }
        foreach ($key in $edgeKeysUser) {
            Remove-Item -Path $key.PSPath -Recurse -Force -ErrorAction Stop
        }
    }
} catch {
    Write-Warn "Failed to clean user StartMenuInternet: $_"
}

Write-Info "`n[5/10] Removing protocol associations..."
foreach ($protocol in $protocols) {
    try {
        $protocolPath = "HKLM:\SOFTWARE\Classes\$protocol"
        if (Test-Path $protocolPath) {
            $openCommand = Get-ItemProperty -Path "$protocolPath\shell\open\command" -ErrorAction SilentlyContinue
            if ($openCommand -and $openCommand.'(default)' -like "*msedge*") {
                Remove-Item -Path "$protocolPath\shell\open" -Recurse -Force -ErrorAction Stop
                Write-Success "Cleared $protocol protocol handler"
            }
        }
        
        # HKCU protocols
        $protocolPathUser = "HKCU:\SOFTWARE\Classes\$protocol"
        if (Test-Path $protocolPathUser) {
            $openCommandUser = Get-ItemProperty -Path "$protocolPathUser\shell\open\command" -ErrorAction SilentlyContinue
            if ($openCommandUser -and $openCommandUser.'(default)' -like "*msedge*") {
                Remove-Item -Path "$protocolPathUser\shell\open" -Recurse -Force -ErrorAction Stop
            }
        }
    } catch {
        Write-Warn "Failed to clear $protocol protocol: $_"
    }
}

Write-Info "`n[6/10] Removing file associations..."
foreach ($ext in $fileAssociations) {
    try {
        # HKLM
        $extPath = "HKLM:\SOFTWARE\Classes\$ext"
        if (Test-Path $extPath) {
            $currentHandler = Get-ItemProperty -Path $extPath -ErrorAction SilentlyContinue
            if ($currentHandler.'(default)' -in $edgeProgIds) {
                Remove-ItemProperty -Path $extPath -Name "(default)" -Force -ErrorAction Stop
                Write-Success "Cleared $ext association in HKLM"
            }
        }
        
        # Remove OpenWithProgids
        $openWithPath = "$extPath\OpenWithProgids"
        if (Test-Path $openWithPath) {
            foreach ($progId in $edgeProgIds) {
                Remove-ItemProperty -Path $openWithPath -Name $progId -Force -ErrorAction SilentlyContinue
            }
        }
        
        # HKCU
        $extPathUser = "HKCU:\SOFTWARE\Classes\$ext"
        if (Test-Path $extPathUser) {
            $currentHandlerUser = Get-ItemProperty -Path $extPathUser -ErrorAction SilentlyContinue
            if ($currentHandlerUser.'(default)' -in $edgeProgIds) {
                Remove-ItemProperty -Path $extPathUser -Name "(default)" -Force -ErrorAction SilentlyContinue
            }
        }
        
        $openWithPathUser = "$extPathUser\OpenWithProgids"
        if (Test-Path $openWithPathUser) {
            foreach ($progId in $edgeProgIds) {
                Remove-ItemProperty -Path $openWithPathUser -Name $progId -Force -ErrorAction SilentlyContinue
            }
        }
    } catch {
        Write-Warn "Failed to clear $ext association: $_"
    }
}

Write-Info "`n[7/10] Removing App Paths registration..."
try {
    $appPathKeys = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe",
        "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe"
    )
    
    foreach ($appPath in $appPathKeys) {
        if (Test-Path $appPath) {
            Remove-Item -Path $appPath -Recurse -Force -ErrorAction Stop
            Write-Success "Removed App Path registration"
        }
    }
} catch {
    Write-Warn "Failed to remove App Paths: $_"
}

Write-Info "`n[8/10] Cleaning RegisteredApplications..."
try {
    $regAppsPath = "HKLM:\SOFTWARE\RegisteredApplications"
    $edgeApp = Get-ItemProperty -Path $regAppsPath -ErrorAction SilentlyContinue | 
               Get-Member -MemberType NoteProperty | 
               Where-Object { $_.Name -like "*Edge*" }
    
    foreach ($app in $edgeApp) {
        Remove-ItemProperty -Path $regAppsPath -Name $app.Name -Force -ErrorAction Stop
        Write-Success "Removed $($app.Name) from RegisteredApplications"
    }
} catch {
    Write-Warn "Failed to clean RegisteredApplications: $_"
}

Write-Info "`n[9/10] Removing Capabilities registrations..."
$capabilitiesPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Capabilities"
try {
    $edgeCaps = Get-ChildItem -Path $capabilitiesPath -ErrorAction SilentlyContinue | 
                Where-Object { $_.PSChildName -like "*Edge*" }
    
    foreach ($cap in $edgeCaps) {
        Remove-Item -Path $cap.PSPath -Recurse -Force -ErrorAction Stop
        Write-Success "Removed capability: $($cap.PSChildName)"
    }
} catch {
    Write-Warn "Failed to clean Capabilities: $_"
}

Write-Info "`n[10/10] Removing client registration and policies..."
try {
    # Remove from Clients list
    $clientsPath = "HKLM:\SOFTWARE\Clients\StartMenuInternet"
    if (Test-Path $clientsPath) {
        $defaultBrowser = Get-ItemProperty -Path $clientsPath -ErrorAction SilentlyContinue
        if ($defaultBrowser.'(default)' -like "*Edge*") {
            Remove-ItemProperty -Path $clientsPath -Name "(default)" -Force -ErrorAction SilentlyContinue
            Write-Success "Cleared default browser setting"
        }
    }
    
    # Remove Edge-specific policies
    $policyPaths = @(
        "HKLM:\SOFTWARE\Policies\Microsoft\Edge",
        "HKLM:\SOFTWARE\Policies\Microsoft\EdgeUpdate",
        "HKCU:\SOFTWARE\Policies\Microsoft\Edge"
    )
    
    foreach ($policyPath in $policyPaths) {
        if (Test-Path $policyPath) {
            Remove-Item -Path $policyPath -Recurse -Force -ErrorAction Stop
            Write-Success "Removed policy: $policyPath"
        }
    }
} catch {
    Write-Warn "Failed to clean client registrations: $_"
}

Write-Info "`n[FINAL] Notifying shell of changes..."
try {
    # Notify the system that file associations have changed
    $signature = @'
    [DllImport("shell32.dll", CharSet = CharSet.Auto, SetLastError = true)]
    public static extern void SHChangeNotify(uint wEventId, uint uFlags, IntPtr dwItem1, IntPtr dwItem2);
'@
    $type = Add-Type -MemberDefinition $signature -Name ShellNotify -Namespace Win32 -PassThru
    $type::SHChangeNotify(0x08000000, 0x0000, [IntPtr]::Zero, [IntPtr]::Zero)
    Write-Success "Shell notification sent"
} catch {
    Write-Warn "Could not send shell notification: $_"
}

Write-Success "`n=========================================="
Write-Success "Edge unregistration completed!"
Write-Success "=========================================="
Write-Info "`nNotes:"
Write-Info "- Edge executables were NOT deleted (only unregistered)"
Write-Info "- Restart Windows to complete the process"
Write-Info "- Some Windows features may prompt for a browser selection"
Write-Warn "`nTo re-register Edge, run Edge installer or Windows Update"

# Optional: Create restore point
Write-Info "`nWould you like to create a system restore point? (recommended)"
$restoreChoice = Read-Host "Create restore point? (yes/no)"
if ($restoreChoice -eq "yes") {
    try {
        Checkpoint-Computer -Description "Before Edge Unregistration" -RestorePointType "MODIFY_SETTINGS"
        Write-Success "Restore point created successfully"
    } catch {
        Write-Warn "Failed to create restore point: $_"
    }
}

Write-Info "`nPress any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
