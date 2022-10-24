# check list buckets
aws --endpoint-url=http://localhost:4566 s3api list-buckets
# create bucket
aws --endpoint-url=http://localhost:4566 s3api create-bucket --bucket sales-storage --region eu-central-1 --create-bucket-configuration LocationConstraint=eu-central-1
# check list buckets
aws --endpoint-url=http://localhost:4566 s3api list-buckets
# upload
aws --endpoint-url=http://localhost:4566 s3 cp sales/sales.parquet s3://sales-storage/
# check files
aws --endpoint-url=http://localhost:4566 s3api list-objects-v2 --bucket sales-storage