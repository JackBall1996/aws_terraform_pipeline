import sys
import boto3
from awsglue.utils import getResolvedOptions

args = getResolvedOptions(
    sys.argv,
    ["SOURCE_BUCKET", "SOURCE_PREFIX", "DEST_BUCKET", "DEST_PREFIX"]
)

s3 = boto3.client("s3")

source_bucket = args["SOURCE_BUCKET"]
source_prefix = args["SOURCE_PREFIX"]
dest_bucket   = args["DEST_BUCKET"]
dest_prefix   = args["DEST_PREFIX"]

# Ensure prefixes have trailing slash if needed
if source_prefix and not source_prefix.endswith("/"):
    source_prefix += "/"
if dest_prefix and not dest_prefix.endswith("/"):
    dest_prefix += "/"

# Build full source and destination keys
source_key_full = f"{source_prefix}{source_key}" if source_prefix else source_key
dest_key = f"{dest_prefix}{source_key_full}" if dest_prefix else source_key_full

print(f"Copying s3://{source_bucket}/{source_key_full} → s3://{dest_bucket}/{dest_key}")

s3.copy_object(
    Bucket=dest_bucket,
    CopySource={"Bucket": source_bucket, "Key": source_key_full},
    Key=dest_key
)

print("Copy completed")
