import sys
import boto3
from awsglue.utils import getResolvedOptions

args = getResolvedOptions(
    sys.argv,
    ["SOURCE_BUCKET", "SOURCE_PREFIX", "DEST_BUCKET", "DEST_PREFIX"]
)

SOURCE_BUCKET = args["SOURCE_BUCKET"]
SOURCE_PREFIX = args["SOURCE_PREFIX"].lstrip("/")
DEST_BUCKET   = args["DEST_BUCKET"]
DEST_PREFIX   = args["DEST_PREFIX"].rstrip("/") + "/"

print(f"SOURCE_BUCKET={SOURCE_BUCKET}")
print(f"SOURCE_PREFIX={SOURCE_PREFIX}")
print(f"DEST_BUCKET={DEST_BUCKET}")
print(f"DEST_PREFIX={DEST_PREFIX}")

s3 = boto3.client("s3")

paginator = s3.get_paginator("list_objects_v2")

pages = paginator.paginate(
    Bucket=SOURCE_BUCKET,
    Prefix=SOURCE_PREFIX
)

copied_count = 0

for page in pages:
    for obj in page.get("Contents", []):

        source_key = obj["Key"]

        # Skip folder markers
        if source_key.endswith("/"):
            continue

        # Remove source prefix and build destination key
        relative_key = source_key[len(SOURCE_PREFIX):]
        dest_key = f"{DEST_PREFIX}{relative_key}"

        print(
            f"Copying s3://{SOURCE_BUCKET}/{source_key} "
            f"→ s3://{DEST_BUCKET}/{dest_key}"
        )

        s3.copy_object(
            Bucket=DEST_BUCKET,
            Key=dest_key,
            CopySource={
                "Bucket": SOURCE_BUCKET,
                "Key": source_key
            }
        )

print("Copy completed")
