# Terraform Aws s3 static website hosting
This project demonstrates how to use terraform to create an aws s3 bucket and host a static website

## Features

- Creates an S3 bucket for static website hosting
- Uploads `index.html` and `error.html` to the bucket
- Configures public access and website settings

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed
- AWS CLI configured with appropriate credentials

## Usage

1. **Clone the repository:**
   ```sh
   git clone https://github.com/archika31/s3-terraform.git
   cd s3-terraform
   ```

2. **Initialize Terraform:**
   ```sh
   terraform init
   ```

3. **Review and apply the configuration:**
   ```sh
   terraform plan
   terraform apply -auto-approve
   ```

4. **Access your website:**
   - After apply, Terraform will output the S3 website endpoint URL.

## Files

- `main.tf` – Terraform configuration for S3 bucket and website hosting
- `index.html` – Main page for your static site
- `error.html` – Error page for your static site
- `terraform.tfvars` – Variable values for your Terraform configuration (add your region_name and bucket_name values here )
- `variables.tf` – Input variable definitions for your Terraform configuration


## Clean Up

To remove all resources created by this project:
```sh
terraform destroy -auto-approve
```

## Notes

- Make sure your AWS credentials have permissions to create S3 buckets and objects.
- S3 static website hosting does **not** support HTTPS by default.

---
