#!/bin/bash
# Sites backup script
source_dir=$PT_source_dir
target_dir=$PT_target_dir

# Target directory using a timestamp
day=$(date +%Y%m%d-%H%M%S)
target_dir_bkp="$target_dir/$day"
mkdir -p $target_dir_bkp

# Backup the files
echo "$(date) Backing up $source_dir to $target_dir_bkp"
cp -aR $source_dir/* $target_dir_bkp
echo "$(date) Backup finished"

# Diff to verify (diff returns a non-zero exit code if it finds a4ny differences
diff --recursive $source_dir $target_dir_bkp