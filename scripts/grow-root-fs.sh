#!/bin/bash
set -euo pipefail
echo '=== before ==='
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS
df -hT /
sudo growpart /dev/nvme0n1 1
sudo resize2fs /dev/nvme0n1p1
echo '=== after ==='
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS
df -hT /
