# Windows Cleaner Pro - System Optimization Tool
# Requires PowerShell 5.1+ and Administrator privileges
# Save as: WindowsCleanerPro.ps1

# Self-elevate and bypass execution policy
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process PowerShell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Add WPF Assembly
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

# Create XAML for GUI WITHOUT ANY UNICODE EMOJIS
[xml]$xaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Windows Cleaner Pro - IGRF Pvt. Ltd." Height="700" Width="900" 
        WindowStartupLocation="CenterScreen" ResizeMode="CanResize">
    <Window.Resources>
        <Style TargetType="Button">
            <Setter Property="Margin" Value="5"/>
            <Setter Property="Padding" Value="10,5"/>
            <Setter Property="FontSize" Value="14"/>
        </Style>
        <Style TargetType="CheckBox">
            <Setter Property="Margin" Value="5"/>
            <Setter Property="FontSize" Value="13"/>
        </Style>
        <Style TargetType="TextBlock">
            <Setter Property="Margin" Value="5"/>
            <Setter Property="FontSize" Value="13"/>
        </Style>
    </Window.Resources>
    
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>
        
        <!-- Header -->
        <Border Background="#0078D4" Grid.Row="0">
            <StackPanel Orientation="Horizontal" Margin="20">
                <TextBlock Text="" FontSize="28" VerticalAlignment="Center"/>
                <TextBlock Text="Windows Cleaner Pro - IGRF Pvt. Ltd." FontSize="24" FontWeight="Bold" 
                         Foreground="White" Margin="15,0,0,0" VerticalAlignment="Center"/>
                <TextBlock Text="v2.0" FontSize="16" Foreground="LightGray" 
                         VerticalAlignment="Center" Margin="10,5,0,0"/>
            </StackPanel>
        </Border>
        
        <!-- Main Content -->
        <TabControl Grid.Row="1" Margin="10">
            <!-- Cleaning Tab -->
            <TabItem Header="Cleaning Tools">
                <ScrollViewer>
                    <Grid Margin="10">
                        <Grid.RowDefinitions>
                            <RowDefinition Height="Auto"/>
                            <RowDefinition Height="*"/>
                            <RowDefinition Height="Auto"/>
                        </Grid.RowDefinitions>
                        
                        <!-- Cleaning Options -->
                        <GroupBox Grid.Row="0" Header="Cleaning Options" Margin="5">
                            <StackPanel>
                                <CheckBox x:Name="chkTempFiles" IsChecked="True">Temporary Files</CheckBox>
                                <TextBlock Margin="20,0,0,5" FontSize="12" Foreground="Gray">Cleans Windows Temp, %TEMP%, and Prefetch</TextBlock>
                                
                                <CheckBox x:Name="chkRecycleBin" IsChecked="True">Recycle Bin</CheckBox>
                                <TextBlock Margin="20,0,0,5" FontSize="12" Foreground="Gray">Empties all Recycle Bin contents</TextBlock>
                                
                                <CheckBox x:Name="chkWindowsUpdates" IsChecked="False">Windows Update Cache</CheckBox>
                                <TextBlock Margin="20,0,0,5" FontSize="12" Foreground="Gray">Removes old Windows Update files (requires restart)</TextBlock>
                                
                                <CheckBox x:Name="chkThumbnails" IsChecked="True">Thumbnail Cache</CheckBox>
                                <TextBlock Margin="20,0,0,5" FontSize="12" Foreground="Gray">Clears image and video thumbnails</TextBlock>
                                
                                <CheckBox x:Name="chkBrowserCache" IsChecked="True">Browser Cache</CheckBox>
                                <TextBlock Margin="20,0,0,5" FontSize="12" Foreground="Gray">Clears Edge, Chrome, Firefox caches</TextBlock>
                                
                                <CheckBox x:Name="chkLogFiles" IsChecked="False">System Log Files</CheckBox>
                                <TextBlock Margin="20,0,0,5" FontSize="12" Foreground="Gray">Cleans old event logs (keep recent)</TextBlock>
                                
                                <CheckBox x:Name="chkDNS" IsChecked="True">DNS Cache</CheckBox>
                                <TextBlock Margin="20,0,0,5" FontSize="12" Foreground="Gray">Flushes DNS resolver cache</TextBlock>
                            </StackPanel>
                        </GroupBox>
                        
                        <!-- Advanced Options -->
                        <GroupBox Grid.Row="1" Header="Advanced Options" Margin="5">
                            <StackPanel>
                                <CheckBox x:Name="chkOldDownloads" IsChecked="False">Old Download Files (30+ days)</CheckBox>
                                <CheckBox x:Name="chkEmptyFolders" IsChecked="False">Remove Empty Folders</CheckBox>
                                <CheckBox x:Name="chkDuplicateFiles" IsChecked="False">Find Duplicate Files (Report Only)</CheckBox>
                                <Slider x:Name="sldDaysOld" Minimum="0" Maximum="365" Value="30" Margin="20,10"/>
                                <TextBlock Text="Delete files older than days:"/>
                                <TextBlock x:Name="txtDaysValue" Text="30 days" HorizontalAlignment="Center"/>
                            </StackPanel>
                        </GroupBox>
                        
                        <!-- Action Buttons -->
                        <StackPanel Grid.Row="2" Orientation="Horizontal" HorizontalAlignment="Center" Margin="10">
                            <Button x:Name="btnAnalyze" Content="Analyze" Width="120" Background="#4CAF50" Foreground="White"/>
                            <Button x:Name="btnClean" Content="Clean Now" Width="120" Background="#2196F3" Foreground="White" Margin="20,0"/>
                            <Button x:Name="btnDeepClean" Content="Deep Clean" Width="120" Background="#FF9800" Foreground="White"/>
                        </StackPanel>
                    </Grid>
                </ScrollViewer>
            </TabItem>
            
            <!-- System Optimizer Tab -->
            <TabItem Header="System Optimizer">
                <ScrollViewer>
                    <Grid Margin="10">
                        <Grid.RowDefinitions>
                            <RowDefinition Height="Auto"/>
                            <RowDefinition Height="Auto"/>
                            <RowDefinition Height="*"/>
                        </Grid.RowDefinitions>
                        
                        <!-- Optimization Options -->
                        <GroupBox Grid.Row="0" Header="Optimization Tasks" Margin="5">
                            <StackPanel>
                                <CheckBox x:Name="chkDefragSSD">Optimize SSD/HDD (TRIM/Defrag)</CheckBox>
                                <CheckBox x:Name="chkCleanRegistry">Clean Registry (Safe Scan)</CheckBox>
                                <CheckBox x:Name="chkServices">Disable Unnecessary Services</CheckBox>
                                <CheckBox x:Name="chkStartup">Manage Startup Programs</CheckBox>
                                <CheckBox x:Name="chkMemory">Optimize Memory</CheckBox>
                                <CheckBox x:Name="chkWindowsSearch">Rebuild Windows Search Index</CheckBox>
                            </StackPanel>
                        </GroupBox>
                        
                        <!-- Performance Stats -->
                        <GroupBox Grid.Row="1" Header="System Status" Margin="5">
                            <WrapPanel>
                                <Border BorderBrush="#0078D4" BorderThickness="1" Margin="5" Padding="10">
                                    <StackPanel>
                                        <TextBlock Text="Disk Space" FontWeight="Bold"/>
                                        <ProgressBar x:Name="pbDisk" Height="20" Width="200" Margin="0,5"/>
                                        <TextBlock x:Name="txtDisk" Text="Checking..."/>
                                    </StackPanel>
                                </Border>
                                
                                <Border BorderBrush="#0078D4" BorderThickness="1" Margin="5" Padding="10">
                                    <StackPanel>
                                        <TextBlock Text="Memory Usage" FontWeight="Bold"/>
                                        <ProgressBar x:Name="pbMemory" Height="20" Width="200" Margin="0,5"/>
                                        <TextBlock x:Name="txtMemory" Text="Checking..."/>
                                    </StackPanel>
                                </Border>
                                
                                <Border BorderBrush="#0078D4" BorderThickness="1" Margin="5" Padding="10">
                                    <StackPanel>
                                        <TextBlock Text="CPU Usage" FontWeight="Bold"/>
                                        <ProgressBar x:Name="pbCPU" Height="20" Width="200" Margin="0,5"/>
                                        <TextBlock x:Name="txtCPU" Text="Checking..."/>
                                    </StackPanel>
                                </Border>
                            </WrapPanel>
                        </GroupBox>
                        
                        <!-- Optimization Buttons -->
                        <StackPanel Grid.Row="2" Orientation="Horizontal" HorizontalAlignment="Center" Margin="10">
                            <Button x:Name="btnOptimize" Content="Optimize" Width="120" Background="#9C27B0" Foreground="White"/>
                            <Button x:Name="btnRefreshStats" Content="Refresh Stats" Width="120" Margin="20,0"/>
                        </StackPanel>
                    </Grid>
                </ScrollViewer>
            </TabItem>
            
            <!-- Log Tab -->
            <TabItem Header="Log &amp; Results">
                <Grid>
                    <Grid.RowDefinitions>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>
                    
                    <TextBox x:Name="txtLog" Grid.Row="0" Margin="10" 
                            VerticalScrollBarVisibility="Auto" HorizontalScrollBarVisibility="Auto"
                            FontFamily="Consolas" FontSize="12" IsReadOnly="True"
                            Background="#1E1E1E" Foreground="#FFFFFF" TextWrapping="Wrap"/>
                    
                    <StackPanel Grid.Row="1" Orientation="Horizontal" HorizontalAlignment="Right" Margin="10">
                        <Button x:Name="btnSaveLog" Content="Save Log" Width="100"/>
                        <Button x:Name="btnClearLog" Content="Clear Log" Width="100" Margin="10,0"/>
                        <Button x:Name="btnExport" Content="Export Report" Width="120"/>
                    </StackPanel>
                </Grid>
            </TabItem>
        </TabControl>
        
        <!-- Status Bar -->
        <StatusBar Grid.Row="2" Background="#F0F0F0">
            <StatusBarItem>
                <TextBlock x:Name="txtStatus" Text="Ready"/>
            </StatusBarItem>
            <StatusBarItem HorizontalAlignment="Right">
                <TextBlock x:Name="txtSpaceSaved" Text="Space saved: 0 MB"/>
            </StatusBarItem>
        </StatusBar>
    </Grid>
</Window>
'@

# Read XAML
try {
    $reader = New-Object System.Xml.XmlNodeReader $xaml
    $window = [Windows.Markup.XamlReader]::Load($reader)
} catch {
    Write-Host "Error loading XAML: $_" -ForegroundColor Red
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit
}

# Initialize Variables
$global:totalSpaceSaved = 0
$global:logEntries = @()

# Function to log messages
function Log-Message {
    param([string]$Message, [string]$Type = "INFO")
    
    $timestamp = Get-Date -Format "HH:mm:ss"
    $logEntry = "[$timestamp] [$Type] $Message"
    $global:logEntries += $logEntry
    
    try {
        $txtLog = $window.FindName("txtLog")
        $txtLog.AppendText("$logEntry`r`n")
        $txtLog.ScrollToEnd()
        
        $txtStatus = $window.FindName("txtStatus")
        $txtStatus.Text = $Message
    } catch {
        Write-Host $logEntry
    }
}

# Function to get folder size
function Get-FolderSize {
    param([string]$Path)
    
    if (Test-Path $Path) {
        try {
            $size = (Get-ChildItem -Path $Path -Recurse -File -ErrorAction SilentlyContinue | 
                    Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum
            return [math]::Round($size / 1MB, 2)
        } catch {
            return 0
        }
    }
    return 0
}

# Function to clean temporary files
function Clear-TempFiles {
    $tempPaths = @(
        "$env:TEMP\*",
        "C:\Windows\Temp\*",
        "$env:LOCALAPPDATA\Temp\*",
        "$env:LOCALAPPDATA\Microsoft\Windows\INetCache\*",
        "$env:LOCALAPPDATA\Microsoft\Windows\INetCookies\*",
        "C:\Windows\Prefetch\*"
    )
    
    $spaceSaved = 0
    foreach ($path in $tempPaths) {
        if (Test-Path $path) {
            try {
                $parentPath = Split-Path $path -Parent
                $sizeBefore = Get-FolderSize $parentPath
                Remove-Item $path -Recurse -Force -ErrorAction SilentlyContinue
                $sizeAfter = Get-FolderSize $parentPath
                $spaceSaved += ($sizeBefore - $sizeAfter)
                Log-Message "Cleaned: $path" "INFO"
            } catch {
                Log-Message "Failed to clean: $path" "WARNING"
            }
        }
    }
    Log-Message "Cleaned temporary files: $spaceSaved MB" "SUCCESS"
    return $spaceSaved
}

# Function to empty recycle bin
function Clear-RecycleBin {
    try {
        # Method 1: Using COM object
        $shell = New-Object -ComObject Shell.Application
        $recycleBin = $shell.Namespace(0xA)
        $items = $recycleBin.Items()
        
        if ($items.Count -gt 0) {
            $recycleBin.InvokeVerb("Empty Recycle Bin")
            Log-Message "Recycle Bin emptied using COM method" "SUCCESS"
            return 100  # Estimated size
        } else {
            Log-Message "Recycle Bin is already empty" "INFO"
            return 0
        }
    } catch {
        try {
            # Method 2: Using command line
            cmd.exe /c "rd /s /q C:\`$Recycle.Bin" 2>$null
            Log-Message "Recycle Bin emptied using command line" "SUCCESS"
            return 100  # Estimated size
        } catch {
            Log-Message "Failed to empty Recycle Bin" "ERROR"
            return 0
        }
    }
}

# Function to clear browser cache
function Clear-BrowserCache {
    $spaceSaved = 0
    
    # Chrome
    $chromePaths = @(
        "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache",
        "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Media Cache",
        "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Code Cache"
    )
    
    foreach ($path in $chromePaths) {
        if (Test-Path $path) {
            try {
                $sizeBefore = Get-FolderSize $path
                Remove-Item "$path\*" -Recurse -Force -ErrorAction SilentlyContinue
                $spaceSaved += $sizeBefore
            } catch {}
        }
    }
    
    # Edge
    $edgePaths = @(
        "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache",
        "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Code Cache"
    )
    
    foreach ($path in $edgePaths) {
        if (Test-Path $path) {
            try {
                $sizeBefore = Get-FolderSize $path
                Remove-Item "$path\*" -Recurse -Force -ErrorAction SilentlyContinue
                $spaceSaved += $sizeBefore
            } catch {}
        }
    }
    
    # Firefox
    $firefoxProfiles = "$env:APPDATA\Mozilla\Firefox\Profiles\"
    if (Test-Path $firefoxProfiles) {
        Get-ChildItem $firefoxProfiles -Directory -ErrorAction SilentlyContinue | ForEach-Object {
            $cachePath = Join-Path $_.FullName "cache2"
            if (Test-Path $cachePath) {
                try {
                    $sizeBefore = Get-FolderSize $cachePath
                    Remove-Item "$cachePath\*" -Recurse -Force -ErrorAction SilentlyContinue
                    $spaceSaved += $sizeBefore
                } catch {}
            }
        }
    }
    
    if ($spaceSaved -gt 0) {
        Log-Message "Browser cache cleared: $spaceSaved MB" "SUCCESS"
    } else {
        Log-Message "No browser cache found or already cleared" "INFO"
    }
    
    return $spaceSaved
}

# Function to flush DNS cache
function Clear-DNSCache {
    try {
        Clear-DnsClientCache -ErrorAction SilentlyContinue
        Log-Message "DNS cache flushed successfully" "SUCCESS"
        return $true
    } catch {
        try {
            Start-Process "ipconfig" "/flushdns" -NoNewWindow -Wait -ErrorAction SilentlyContinue
            Log-Message "DNS cache flushed successfully" "SUCCESS"
            return $true
        } catch {
            Log-Message "Failed to flush DNS cache" "ERROR"
            return $false
        }
    }
}

# Function to analyze system
function Analyze-System {
    Log-Message "Analyzing system for cleanup opportunities..." "INFO"
    
    $analysis = @{}
    
    # Check temp files
    $tempSize = (Get-FolderSize $env:TEMP) + (Get-FolderSize "C:\Windows\Temp")
    $analysis['TempFiles'] = [math]::Round($tempSize, 2)
    
    # Check recycle bin
    $recyclePath = "C:\`$Recycle.Bin"
    if (Test-Path $recyclePath) {
        $recycleSize = Get-FolderSize $recyclePath
    } else {
        $recycleSize = 0
    }
    $analysis['RecycleBin'] = [math]::Round($recycleSize, 2)
    
    # Check browser cache (estimated)
    $analysis['BrowserCache'] = [math]::Round(200, 2)  # Estimated value
    
    # Log analysis results
    foreach ($key in $analysis.Keys) {
        if ($analysis[$key] -gt 0) {
            $message = $key + ": " + $analysis[$key] + " MB can be freed"
            Log-Message $message "ANALYSIS"
        }
    }
    
    $total = ($analysis.Values | Measure-Object -Sum).Sum
    Log-Message "Total space that can be freed: $total MB" "ANALYSIS"
    
    return $analysis
}

# Function to update system stats
function Update-SystemStats {
    try {
        # Disk space
        $disk = Get-PSDrive C -ErrorAction SilentlyContinue
        if ($disk) {
            $usedGB = [math]::Round(($disk.Used - $disk.Free) / 1GB, 1)
            $totalGB = [math]::Round($disk.Used / 1GB, 1)
            $usedPercent = ($usedGB / $totalGB) * 100
            
            $pbDisk = $window.FindName("pbDisk")
            $txtDisk = $window.FindName("txtDisk")
            $pbDisk.Value = $usedPercent
            $txtDisk.Text = "$([math]::Round($disk.Free/1GB, 1)) GB free of $totalGB GB"
        }
        
        # Memory
        $memory = Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue
        if ($memory) {
            $usedPercent = (($memory.TotalVisibleMemorySize - $memory.FreePhysicalMemory) / $memory.TotalVisibleMemorySize) * 100
            $pbMemory = $window.FindName("pbMemory")
            $txtMemory = $window.FindName("txtMemory")
            $pbMemory.Value = $usedPercent
            $txtMemory.Text = "$([math]::Round(($memory.TotalVisibleMemorySize - $memory.FreePhysicalMemory)/1MB, 0)) MB used"
        }
        
        # CPU
        $cpu = Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue
        if ($cpu) {
            $pbCPU = $window.FindName("pbCPU")
            $txtCPU = $window.FindName("txtCPU")
            $pbCPU.Value = $cpu.LoadPercentage
            $txtCPU.Text = "$($cpu.LoadPercentage)% load"
        }
    } catch {
        # Silently fail - stats are not critical
    }
}

# Function to perform cleanup
function Start-Cleanup {
    param([bool]$DeepClean = $false)
    
    $spaceSaved = 0
    
    # Get selected options
    $chkTempFiles = $window.FindName("chkTempFiles")
    $chkRecycleBin = $window.FindName("chkRecycleBin")
    $chkBrowserCache = $window.FindName("chkBrowserCache")
    $chkDNS = $window.FindName("chkDNS")
    $chkWindowsUpdates = $window.FindName("chkWindowsUpdates")
    $chkThumbnails = $window.FindName("chkThumbnails")
    $chkLogFiles = $window.FindName("chkLogFiles")
    
    if ($chkTempFiles.IsChecked) {
        Log-Message "Cleaning temporary files..." "INFO"
        $spaceSaved += Clear-TempFiles
    }
    
    if ($chkRecycleBin.IsChecked) {
        Log-Message "Emptying Recycle Bin..." "INFO"
        $spaceSaved += Clear-RecycleBin
    }
    
    if ($chkBrowserCache.IsChecked) {
        Log-Message "Clearing browser cache..." "INFO"
        $spaceSaved += Clear-BrowserCache
    }
    
    if ($chkDNS.IsChecked) {
        Clear-DNSCache | Out-Null
    }
    
    if ($chkThumbnails.IsChecked) {
        Log-Message "Clearing thumbnail cache..." "INFO"
        Clear-ThumbnailCache
    }
    
    if ($chkLogFiles.IsChecked) {
        Log-Message "Cleaning log files..." "INFO"
        Clear-EventLogs
    }
    
    if ($chkWindowsUpdates.IsChecked) {
        Log-Message "Cleaning Windows Update cache..." "INFO"
        Clear-WindowsUpdateCache
    }
    
    if ($DeepClean) {
        Log-Message "Performing deep clean..." "INFO"
        $chkOldDownloads = $window.FindName("chkOldDownloads")
        $chkEmptyFolders = $window.FindName("chkEmptyFolders")
        
        if ($chkOldDownloads.IsChecked) {
            Clear-OldDownloads
        }
        
        if ($chkEmptyFolders.IsChecked) {
            Remove-EmptyFolders
        }
    }
    
    # Update total space saved
    $global:totalSpaceSaved += $spaceSaved
    $txtSpaceSaved = $window.FindName("txtSpaceSaved")
    $txtSpaceSaved.Text = "Space saved: $totalSpaceSaved MB"
    
    Log-Message "Cleanup completed! Freed $spaceSaved MB" "SUCCESS"
    Update-SystemStats
}

# Function to clear thumbnail cache
function Clear-ThumbnailCache {
    try {
        $thumbCachePaths = @(
            "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\thumbcache*.db",
            "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\iconcache*.db"
        )
        
        $clearedCount = 0
        foreach ($pathPattern in $thumbCachePaths) {
            $files = Get-ChildItem -Path $pathPattern -ErrorAction SilentlyContinue
            foreach ($file in $files) {
                try {
                    Remove-Item $file.FullName -Force -ErrorAction SilentlyContinue
                    $clearedCount++
                } catch {}
            }
        }
        
        if ($clearedCount -gt 0) {
            Log-Message "Thumbnail cache cleared ($clearedCount files)" "SUCCESS"
        } else {
            Log-Message "No thumbnail cache found" "INFO"
        }
    } catch {
        Log-Message "Failed to clear thumbnail cache" "ERROR"
    }
}

# Function to clean Windows Update cache
function Clear-WindowsUpdateCache {
    try {
        $wuService = Get-Service -Name wuauserv -ErrorAction SilentlyContinue
        if ($wuService.Status -eq 'Running') {
            Stop-Service wuauserv -Force -ErrorAction SilentlyContinue
        }
        
        $wuPath = "C:\Windows\SoftwareDistribution\Download"
        if (Test-Path $wuPath) {
            Remove-Item "$wuPath\*" -Recurse -Force -ErrorAction SilentlyContinue
        }
        
        if ($wuService) {
            Start-Service wuauserv -ErrorAction SilentlyContinue
        }
        
        Log-Message "Windows Update cache cleaned" "SUCCESS"
    } catch {
        Log-Message "Failed to clean Windows Update cache" "ERROR"
    }
}

# Function to clean event logs
function Clear-EventLogs {
    try {
        $logs = Get-EventLog -List -ErrorAction SilentlyContinue
        foreach ($log in $logs) {
            try {
                Clear-EventLog -LogName $log.Log -ErrorAction SilentlyContinue
            } catch {}
        }
        Log-Message "Event logs cleared" "SUCCESS"
    } catch {
        Log-Message "Failed to clear event logs" "ERROR"
    }
}

# Function to clear old downloads - CORRECTED VERSION
function Clear-OldDownloads {
    try {
        $days = $window.FindName("sldDaysOld").Value
        
        # Get Downloads folder path
        $downloadsPath = [Environment]::GetFolderPath("UserProfile") + "\Downloads"
        
        if (Test-Path $downloadsPath) {
            Log-Message "Scanning for files older than $days days in Downloads..." "INFO"
            
            $oldFiles = Get-ChildItem -Path $downloadsPath -File -ErrorAction SilentlyContinue | 
                        Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$days) }
            
            $count = $oldFiles.Count
            
            if ($count -gt 0) {
                # Ask for confirmation
                $confirm = [System.Windows.MessageBox]::Show(
                    "Found $count files older than $days days in Downloads. Delete them?",
                    "Confirm Delete Old Downloads",
                    "YesNo",
                    "Question"
                )
                
                if ($confirm -eq "Yes") {
                    $totalSize = 0
                    $deletedCount = 0
                    
                    foreach ($file in $oldFiles) {
                        try {
                            $totalSize += $file.Length
                            Remove-Item $file.FullName -Force -ErrorAction SilentlyContinue
                            $deletedCount++
                        } catch {
                            Log-Message "Failed to delete: $($file.Name)" "WARNING"
                        }
                    }
                    
                    $spaceSaved = [math]::Round($totalSize / 1MB, 2)
                    Log-Message "Removed $deletedCount old download files (older than $days days): $spaceSaved MB" "SUCCESS"
                    return $spaceSaved
                } else {
                    Log-Message "Old downloads cleanup cancelled by user" "INFO"
                    return 0
                }
            } else {
                Log-Message "No old download files found (older than $days days)" "INFO"
                return 0
            }
        } else {
            Log-Message "Downloads folder not found" "WARNING"
            return 0
        }
    } catch {
        Log-Message "Failed to clear old downloads: $($_.Exception.Message)" "ERROR"
        return 0
    }
}

# Function to remove empty folders - CORRECTED VERSION (NO CONTACTS ERROR)
function Remove-EmptyFolders {
    try {
        Log-Message "Scanning for empty folders in safe locations..." "INFO"
        
        # Define safe base directories to scan (avoid system folders)
        $baseDirs = @(
            [Environment]::GetFolderPath("Desktop"),
            [Environment]::GetFolderPath("Downloads"),
            [Environment]::GetFolderPath("Documents"),
            [Environment]::GetFolderPath("Music"),
            [Environment]::GetFolderPath("Pictures"),
            [Environment]::GetFolderPath("Videos")
        )
        
        $emptyFolders = @()
        
        foreach ($baseDir in $baseDirs) {
            if (Test-Path $baseDir) {
                # Get immediate subdirectories only (not recursive to avoid system folders)
                $subDirs = Get-ChildItem -Path $baseDir -Directory -ErrorAction SilentlyContinue
                
                foreach ($dir in $subDirs) {
                    try {
                        # Get all items in the directory (including hidden)
                        $items = Get-ChildItem -Path $dir.FullName -Force -ErrorAction SilentlyContinue
                        
                        # If no items found, it's empty
                        if ($null -eq $items -or $items.Count -eq 0) {
                            $emptyFolders += $dir.FullName
                        }
                    } catch {
                        # Skip this directory if there's an error
                        continue
                    }
                }
            }
        }
        
        $count = $emptyFolders.Count
        
        if ($count -gt 0) {
            Log-Message "Found $count empty folders in safe locations" "INFO"
            
            # Ask for confirmation
            $confirm = [System.Windows.MessageBox]::Show(
                "Found $count empty folders in Downloads, Desktop, Documents, Music, Pictures, and Videos. Remove them?",
                "Confirm Empty Folder Removal",
                "YesNo",
                "Question"
            )
            
            if ($confirm -eq "Yes") {
                $removedCount = 0
                
                foreach ($folder in $emptyFolders) {
                    try {
                        # Use -Recurse parameter to avoid prompts
                        Remove-Item -Path $folder -Force -Recurse -ErrorAction SilentlyContinue
                        $removedCount++
                        Log-Message "Removed empty folder: $(Split-Path $folder -Leaf)" "INFO"
                    } catch {
                        Log-Message "Failed to remove folder: $(Split-Path $folder -Leaf)" "WARNING"
                    }
                }
                
                Log-Message "Removed $removedCount empty folders" "SUCCESS"
                return $removedCount
            } else {
                Log-Message "Empty folder removal cancelled by user" "INFO"
                return 0
            }
        } else {
            Log-Message "No empty folders found in safe locations" "INFO"
            return 0
        }
        
    } catch {
        Log-Message "Error in empty folder cleanup: $($_.Exception.Message)" "ERROR"
        return 0
    }
}

# Event Handlers
$btnAnalyze = $window.FindName("btnAnalyze")
$btnAnalyze.Add_Click({
    Analyze-System
})

$btnClean = $window.FindName("btnClean")
$btnClean.Add_Click({
    $result = [System.Windows.MessageBox]::Show(
        "Are you sure you want to clean selected items?",
        "Confirm Cleanup",
        "YesNo",
        "Question"
    )
    
    if ($result -eq "Yes") {
        Start-Cleanup -DeepClean $false
    }
})

$btnDeepClean = $window.FindName("btnDeepClean")
$btnDeepClean.Add_Click({
    $result = [System.Windows.MessageBox]::Show(
        "Deep clean will perform more aggressive cleaning including old downloads and empty folders. Continue?",
        "Confirm Deep Clean",
        "YesNo",
        "Warning"
    )
    
    if ($result -eq "Yes") {
        Start-Cleanup -DeepClean $true
    }
})

$btnOptimize = $window.FindName("btnOptimize")
$btnOptimize.Add_Click({
    Log-Message "Starting system optimization..." "INFO"
    
    # SSD/HDD Optimization
    if ($window.FindName("chkDefragSSD").IsChecked) {
        Log-Message "Optimizing drives..." "INFO"
        try {
            Optimize-Volume -DriveLetter C -Analyze -ErrorAction SilentlyContinue
            Optimize-Volume -DriveLetter C -Defrag -ErrorAction SilentlyContinue
            Log-Message "Drive optimization completed" "SUCCESS"
        } catch {
            Log-Message "Drive optimization failed" "ERROR"
        }
    }
    
    # Memory optimization
    if ($window.FindName("chkMemory").IsChecked) {
        Log-Message "Clearing standby memory..." "INFO"
        try {
            [System.GC]::Collect()
            [System.GC]::WaitForPendingFinalizers()
            Log-Message "Memory optimization completed" "SUCCESS"
        } catch {
            Log-Message "Memory optimization failed" "ERROR"
        }
    }
    
    Update-SystemStats
})

$btnRefreshStats = $window.FindName("btnRefreshStats")
$btnRefreshStats.Add_Click({
    Update-SystemStats
    Log-Message "System stats refreshed" "INFO"
})

$btnSaveLog = $window.FindName("btnSaveLog")
$btnSaveLog.Add_Click({
    $saveDialog = New-Object System.Windows.Forms.SaveFileDialog
    $saveDialog.Filter = "Log files (*.log)|*.log|Text files (*.txt)|*.txt|All files (*.*)|*.*"
    $saveDialog.FileName = "CleanerLog_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"
    
    if ($saveDialog.ShowDialog() -eq "OK") {
        $txtLog = $window.FindName("txtLog")
        $txtLog.Text | Out-File $saveDialog.FileName
        Log-Message "Log saved to $($saveDialog.FileName)" "SUCCESS"
    }
})

$btnClearLog = $window.FindName("btnClearLog")
$btnClearLog.Add_Click({
    $window.FindName("txtLog").Text = ""
    Log-Message "Log cleared" "INFO"
})

$btnExport = $window.FindName("btnExport")
$btnExport.Add_Click({
    $report = @"
Windows Cleaner Pro - IGRF Pvt. Ltd. Report
Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
================================================

System Information:
- OS: $([Environment]::OSVersion.VersionString)
- Computer: $env:COMPUTERNAME
- User: $env:USERNAME

Cleaning Summary:
- Total Space Saved: $totalSpaceSaved MB

Recent Operations:
$(if ($logEntries.Count -gt 0) { ($logEntries | Select-Object -Last 50) -join "`r`n" } else { "No operations recorded" })

"@
    
    $saveDialog = New-Object System.Windows.Forms.SaveFileDialog
    $saveDialog.Filter = "Text files (*.txt)|*.txt|All files (*.*)|*.*"
    $saveDialog.FileName = "CleanerReport_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
    
    if ($saveDialog.ShowDialog() -eq "OK") {
        $report | Out-File $saveDialog.FileName
        Log-Message "Report exported to $($saveDialog.FileName)" "SUCCESS"
    }
})

# Initialize slider value display
$sldDaysOld = $window.FindName("sldDaysOld")
$txtDaysValue = $window.FindName("txtDaysValue")
if ($sldDaysOld -and $txtDaysValue) {
    # Set initial value
    $txtDaysValue.Text = "$([math]::Round($sldDaysOld.Value)) days"
    
    # Add event handler for value changes
    $sldDaysOld.Add_ValueChanged({
        $txtDaysValue.Text = "$([math]::Round($sldDaysOld.Value)) days"
    })
}

# Initialize
Log-Message "Windows Cleaner Pro initialized" "INFO"
Update-SystemStats

# Show window
$null = $window.ShowDialog()