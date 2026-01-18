# AWS CLI Installation Guide for Windows

## Step 1: Download the Installer ✅

The AWS CLI MSI installer download has been initiated. The installer will be downloaded to your **Downloads** folder.

**Download URL:** `https://awscli.amazonaws.com/AWSCLIV2.msi`

---

## Step 2: Run the MSI Installer

Once the download completes:

1. **Open your Downloads folder** and locate `AWSCLIV2.msi`
2. **Double-click** the MSI file to launch the installer
3. **Follow the installation wizard:**
   - Click "Next" on the welcome screen
   - Accept the license agreement
   - Choose installation location (default is recommended)
   - Click "Install"
   - Wait for the installation to complete
   - Click "Finish"

> [!NOTE]
> The installer will automatically add AWS CLI to your system PATH, making it available in all terminal windows.

---

## Step 3: Verify Installation

After installation, **open a new PowerShell or Command Prompt window** (important to open a new window after installation) and run:

```powershell
aws --version
```

You should see output similar to:
```
aws-cli/2.x.x Python/3.x.x Windows/10 exe/AMD64
```

---

## Step 4: Configure AWS CLI

Once installation is verified, configure your AWS credentials:

```powershell
aws configure
```

You'll be prompted to enter:

1. **AWS Access Key ID:** `[Your Access Key]`
2. **AWS Secret Access Key:** `[Your Secret Key]`
3. **Default region name:** e.g., `us-east-1`, `us-west-2`, or `ap-south-1`
4. **Default output format:** `json` (recommended)

> [!IMPORTANT]
> **Don't have AWS credentials yet?**
> 
> Create them in the AWS Management Console:
> 1. Sign in to [AWS Console](https://console.aws.amazon.com/)
> 2. Go to **IAM** (Identity and Access Management)
> 3. Click **Users** → Select your user → **Security credentials**
> 4. Click **Create access key**
> 5. Download and save the credentials securely

---

## Step 5: Test Your Configuration

Verify your AWS connection:

```powershell
aws sts get-caller-identity
```

This should return your AWS account information in JSON format.

---

## Common AWS CLI Commands

Once configured, you can manage AWS services:

```powershell
# List S3 buckets
aws s3 ls

# List EC2 instances
aws ec2 describe-instances

# List Lambda functions
aws lambda list-functions

# Get AWS account information
aws sts get-caller-identity

# List available AWS regions
aws ec2 describe-regions --output table
```

---

## Managing Multiple Profiles

If you work with multiple AWS accounts, use named profiles:

```powershell
# Configure a new profile
aws configure --profile myprofile

# Use a specific profile
aws s3 ls --profile myprofile

# Set default profile (optional)
$env:AWS_PROFILE="myprofile"
```

---

## Configuration Files Location

Your AWS configuration is stored at:
- **Credentials:** `C:\Users\Aditya\.aws\credentials`
- **Config:** `C:\Users\Aditya\.aws\config`

---

## Security Best Practices

> [!CAUTION]
> - **Never share** your AWS credentials
> - **Never commit** credentials to version control
> - **Use IAM roles** when possible (for EC2, Lambda, etc.)
> - **Rotate access keys** regularly
> - **Use least privilege** - grant only necessary permissions

---

## Next Steps

After installation and configuration:

1. ✅ Verify installation with `aws --version`
2. ✅ Configure credentials with `aws configure`
3. ✅ Test connection with `aws sts get-caller-identity`
4. 🚀 Start managing your AWS resources!

---

## Troubleshooting

**Command not found after installation?**
- Close and reopen your terminal window
- Restart your computer if the issue persists

**Authentication errors?**
- Verify your credentials are correct
- Check if your IAM user has the necessary permissions
- Ensure your access key is active in the AWS Console

**Need help?**
- AWS CLI Documentation: https://docs.aws.amazon.com/cli/
- AWS CLI Command Reference: https://awscli.amazonaws.com/v2/documentation/api/latest/index.html
