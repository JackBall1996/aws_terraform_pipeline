import sys
import boto3
from awsglue.utils import getResolvedOptions

args = getResolvedOptions(
    sys.argv,
    ["SOURCE_BUCKET", "SOURCE_KEY", "DEST_BUCKET"]
)

s3 = boto3.client("s3")

source_bucket = args["SOURCE_BUCKET"]
source_key = args["SOURCE_KEY"]
dest_bucket = args["DEST_BUCKET"]

dest_key = source_key  # preserve path

print(f"Copying s3://{source_bucket}/{source_key} → s3://{dest_bucket}/{dest_key}")

s3.copy_object(
    Bucket=dest_bucket,
    CopySource={"Bucket": source_bucket, "Key": source_key},
    Key=dest_key
)

print("Copy completed")
