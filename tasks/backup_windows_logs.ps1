[CmdletBinding()]
Param(
[Parameter(Mandatory = $True)]
[String]
$source_dir,

[Parameter(Mandatory = $True)]
[String]
$target_dir
)

# Create date stamp for backup sub directory
$date_stamp = Get-Date -UFormat "+%Y%m%d-%H%M%S"

# Create subdir with timestamp in target backup dir
$full_target_backup_path = Join-Path -Path "c:\backups\" -ChildPath "site_backup_$date_stamp"

# Copy contents of source dir to full backup path target
Write-Output "Copying items from $source_dir to full backup path $full_target_backup_path"
Copy-Item -Recurse -Path "c:tools\nginx-1.21.6\logs\" -Destination $full_target_backup_path
