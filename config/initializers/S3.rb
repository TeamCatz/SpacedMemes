#TODO fill in values
S3_BUCKET_NAME = 'spaceapps2015'
S3_AWS_ACCESS_KEY_ID = ''
S3_AWS_SECRET_ACCESS_KEY = ''


#Aws.config(:credentials =>{:access_key_id => S3_AWS_ACCESS_KEY_ID, :secret_access_key =>  S3_AWS_SECRET_ACCESS_KEY})
S3_CLIENT = Aws::S3::Resource.new(
    access_key_id: S3_AWS_ACCESS_KEY_ID,
    secret_access_key: S3_AWS_SECRET_ACCESS_KEY,
    region: 'us-east-1'
)
S3_BUCKET = S3_CLIENT.bucket S3_BUCKET_NAME

S3_IMAGE_BASE = "https://s3-us-west-1.amazonaws.com/#{S3_BUCKET_NAME}"


