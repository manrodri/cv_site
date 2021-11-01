#!/usr/bin/env /bin/bash

export CLOUD_FRONT_WWW_ID="E1HCQZZMO37PIY"
export CLOUD_FRONT_ROOT_ID="EF80OFT552R90"
export S3_BUCKET='www.manrodri.com'

# UPDATE CONTENT
aws s3 sync . s3://${S3_BUCKET} --profile devops

#INVALIDATE CACHE
#for i in  "E1HCQZZMO37PIY" "EF80OFT552R90"; do
#  aws cloudfront --profile devops create-invalidation --distribution-id $i --paths "/*";
#done


aws cloudfront --profile devops create-invalidation --distribution-id "E1HCQZZMO37PIY" --paths "/*";
aws cloudfront --profile devops create-invalidation --distribution-id "EF80OFT552R90" --paths "/*";

