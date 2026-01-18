# Terraform Manual Installation Guide for Windows

## Download Complete ✅

Terraform v1.14.3 for Windows AMD64 has been downloaded to your Downloads folder.

**File:** `terraform_1.14.3_windows_amd64.zip`

---

## Installation Steps

### Step 1: Extract the ZIP File

1. Open your **Downloads** folder
2. Locate `terraform_1.14.3_windows_amd64.zip`
3. Right-click and select **"Extract All..."**
4. Extract to: `C:\terraform\` (create this folder if it doesn't exist)
   - Alternatively, you can extract to any location you prefer

After extraction, you should have: `C:\terraform\terraform.exe`

---

### Step 2: Add Terraform to System PATH

To make Terraform accessible from any command prompt:

1. Press `Win + X` and select **"System"**
2. Click **"Advanced system settings"** on the right
3. Click **"Environment Variables..."** button
4. Under **"System variables"** (bottom section), find and select **"Path"**
5. Click **"Edit..."**
6. Click **"New"**
7. Add: `C:\terraform`
8. Click **"OK"** on all windows to save

**Alternative: Using PowerShell (Administrator)**

```powershell
# Add to system PATH (requires admin privileges)
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\terraform", [System.EnvironmentVariableTarget]::Machine)
```

---

### Step 3: Verify Installation

**Close and reopen your PowerShell window** (important!), then run:

```powershell
terraform --version
```

You should see:
```
Terraform v1.14.3
on windows_amd64
```

---

## Alternative: Quick Manual Setup (No PATH modification)

If you don't want to modify system PATH, you can:

1. Extract `terraform.exe` directly to your project folder: `C:\Users\Aditya\Desktop\AWS\`
2. Run terraform from that directory using `.\terraform` instead of `terraform`

---

## Next Steps

Once installation is verified, I'll help you:
- Create your first Terraform project
- Set up AWS provider configuration
- Build example infrastructure code
- Learn the Terraform workflow

---

## Terraform Basics

Terraform follows this workflow:

1. **Write** - Define infrastructure in `.tf` files
2. **Initialize** - `terraform init` (download providers)
3. **Plan** - `terraform plan` (preview changes)
4. **Apply** - `terraform apply` (create infrastructure)
5. **Destroy** - `terraform destroy` (remove infrastructure)

---

## Quick Verification Commands

```powershell
# Check version
terraform --version

# Get help
terraform --help

# Initialize a directory (once Terraform is installed)
terraform init
```
