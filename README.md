# Terraform 

Terraform is an open-source Infrastructure as Code (IaC) tool that lets you define, provision, and manage cloud and on-premise resources (like VMs, networks, databases) using configuration files.

## Pipeline Structure

<u>EventBridge</u>

The event monitors for objects created on the source s3 bucket, once it identifies an item has been created it triggers the lambda functionjob.

<u>Lambda</u>

The Lambda function runs the [s3_copy_job.py](lambda/s3_copy_job.py) script, this script copies any files from the source s3 bucket into the destination s3 bucket.

## Services and Resources

Amazon EC2 has been used to deploy the code in AWS.

An IAM role attached to the EC2 instance has been created with the following policies:
- AmazonEventBridgeFullAccess
- AmazonS3FullAccess
- IAMFullAccess
- CloudWatchLogsFullAccess
- AmazonDynamoDBFullAccess
- AmazonSSMManagedInstanceCore
- AWSLambda_FullAccess
- AWSLambda_ReadOnlyAccess

Then, the following is run on the EC2 instance to install Terraform:

```
sudo yum update -y
sudo yum install -y git unzip

curl -O https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip
unzip terraform_1.6.6_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform version
```

Clone this repo to the EC2 instance:

```
git clone <your-repo-url>
cd repo/terraform
```

Run Terraform: 

```
terraform init
terraform plan
terraform apply
```

The following criteria must be met for Terraform to work:
- The S3 bucket referenced in backend.tf must exist.
    - EventBridge notifications must be enabled for the bucket.
- The DynamoDB table name referenced in [backend.tf](terraform/backend.tf) must exist and have a parition key named 'LockID' of type 'string'.