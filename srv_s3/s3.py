
import os
import uuid
import boto3

# os.environ['AWS_ACCESS_KEY_ID'] = 'key123456'
# os.environ['AWS_SECRET_ACCESS_KEY'] = 'secret56789'
# os.environ.pop('AWS_PROFILE', None)

s3 = boto3.resource('s3', aws_access_key_id='key123456', aws_secret_access_key='secret56789', region_name='us-east-1',
                    endpoint_url="http://localhost:4566", use_ssl=False)

# Print out bucket names
for bucket in s3.buckets.all():
    print('bucket.name', bucket.name)

# create bucket
bucket_name = "python-sdk-sample-%s" % uuid.uuid4()
s3.create_bucket(Bucket=bucket_name)
print("Creating new bucket with name:", bucket_name)

# read bucket
bucket = s3.Bucket('python-sdk-sample-57515101-5f60-4910-9ad3-d6336722cc12')
for obj in bucket.objects.all():
    print('obj.key', obj.key)

# Storing data
# s3.Object('mybucket', 'hello.txt').put(Body=open('/tmp/hello.txt', 'rb'))

# Boto3 Iteration of buckets and keys
for bucket in s3.buckets.all():
    print('bucket.key', bucket)
    for key in bucket.objects.all():
        print('key.key', key.key)

# Boto3
# for key in bucket.objects.all():
#     key.delete()
# bucket.delete()
