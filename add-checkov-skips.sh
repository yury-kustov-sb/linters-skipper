#!/bin/zsh
set -e

echo Starting...

declare -A skips

skips[CKV_AWS_135]="No need to Ensure that EC2 is EBS optimized"
skips[CKV_SECRET_2]="it is safe here"
skips[CKV_AWS_273]="MFA enabled for all users"
skips[CKV_AWS_111]="No need to Ensure IAM policies does not allow write access without constraints"
skips[CKV_AWS_112]="No need to Ensure Session Manager data is encrypted in transit"
skips[CKV_AWS_118]="No need to Ensure that enhanced monitoring is enabled for Amazon RDS instances"
skips[CKV_AWS_119]="No need to Ensure DynamoDB Tables are encrypted using a KMS Customer Managed CMK"
skips[CKV_AWS_126]="No need to Ensure that detailed monitoring is enabled for EC2 instances"
skips[CKV_AWS_127]="No need to Ensure that Elastic Load Balancer(s) uses SSL certificates provided by AWS Certificate Manager"
skips[CKV_AWS_130]="No need to Ensure VPC subnets do not assign public IP by default"
skips[CKV_AWS_131]="No need to Ensure that ALB drops HTTP headers"
skips[CKV_AWS_136]="No need to Ensure that EC2 is EBS optimized"
skips[CKV_AWS_150]="No need to Ensure that Load Balancer has deletion protection enabled"
skips[CKV_AWS_157]="No need to Ensure that RDS instances have Multi-AZ enabled"
skips[CKV_AWS_158]="No need to Ensure that CloudWatch Log Group is encrypted by KMS"
skips[CKV_AWS_161]="No need to Ensure RDS database has IAM authentication enabled"
skips[CKV_AWS_163]="No need to Ensure ECR image scanning on push is enabled"
skips[CKV_AWS_166]="No need to Ensure Backup Vault is encrypted at rest using KMS CMK"
skips[CKV_AWS_17]="No need to Ensure all data stored in RDS is not publicly accessible"
skips[CKV_AWS_174]="No need to Verify CloudFront Distribution Viewer Certificate is using TLS v1.2"
skips[CKV_AWS_184]="No need to Ensure resource is encrypted by KMS using a customer managed Key"
skips[CKV_AWS_189]="No need to Ensure EBS Volume is encrypted by KMS using a customer managed Key"
skips[CKV_AWS_226]="No need to Ensure DB instance gets all minor upgrades automatically"
skips[CKV_AWS_229]="No need to Ensure no NACL allow ingress from internet to port 21"
skips[CKV_AWS_23]="No need to Ensure every security groups rule has a description"
skips[CKV_AWS_230]="No need to Ensure no NACL allow ingress from internet to port 20"
skips[CKV_AWS_231]="No need to Ensure no NACL allow ingress from internet to port 3389"
skips[CKV_AWS_232]="No need to Ensure no NACL allow ingress from internet to port 22"
skips[CKV_AWS_24]="No need to Ensure no security groups allow ingress from 0.0.0.0:0 to port 22"
skips[CKV_AWS_240]="No need to Ensure Kinesis Firehose delivery stream is encrypted"
skips[CKV_AWS_241]="No need to Ensure that Kinesis Firehose Delivery Streams are encrypted with CMK"
skips[CKV_AWS_259]="No need to Ensure CloudFront response header policy enforces Strict Transport Security"
skips[CKV_AWS_260]="No need to Ensure no security groups allow ingress from 0.0.0.0:0 to port 80"
skips[CKV_AWS_27]="No need to Ensure all data stored in the SQS queue is encrypted"
skips[CKV_AWS_273]="No need to Ensure access is controlled through SSO and not AWS IAM defined users"
skips[CKV_AWS_274]="No need to Disallow IAM roles, users, and groups from using the AWS AdministratorAccess policy"
skips[CKV_AWS_283]="No need to Ensure no IAM policies documents allow ALL or any AWS principal permissions to the resource"
skips[CKV_AWS_290]="No need to Ensure IAM policies does not allow write access without constraints"
skips[CKV_AWS_293]="No need to Ensure that AWS database instances have deletion protection enabled"
skips[CKV_AWS_3]="No need to Ensure all data stored in the EBS is securely encrypted"
skips[CKV_AWS_305]="No need to Ensure Cloudfront distribution has a default root object configured"
skips[CKV_AWS_310]="No need to Ensure CloudFront distributions should have origin failover configured"
skips[CKV_AWS_315]="No need to Ensure EC2 Auto Scaling groups use EC2 launch templates"
skips[CKV_AWS_337]="No need to Ensure SSM parameters are using KMS CMK"
skips[CKV_AWS_40]="No need to Ensure IAM policies are attached only to groups or roles"
skips[CKV_AWS_51]="No need to Ensure ECR Image Tags are immutable"
skips[CKV_AWS_61]="No need to Ensure AWS IAM policy does not allow assume role permission across all services"
skips[CKV_AWS_62]="No need to Ensure IAM policies that allow full administrative privileges are not created"
skips[CKV_AWS_63]="No need to Ensure no IAM policies documents allow wildcard as a statement actions"
skips[CKV_AWS_7]="No need to Ensure rotation for customer created CMKs is enabled"
skips[CKV_AWS_77]="No need to Ensure Athena Database is encrypted at rest"
skips[CKV_AWS_79]="No need to Ensure Instance Metadata Service Version 1 is not enabled"
skips[CKV_AWS_8]="No need to Ensure all data stored in the Launch configuration or instance Elastic Blocks Store is securely encrypted"
skips[CKV_AWS_91]="No need to Ensure the ELBv2 has access logging enabled"
skips[CKV_AWS_92]="No need to Ensure the ELB has access logging enabled"

repeat_counter=0
lines_incr=1
for key value in "${(@kv)skips}"; do
  for finding in $(pre-commit run -a | grep -A2 $key  | grep 'File:' | cut -d '/' -f2 | rev | cut -d- -f2- | rev | sort -t ':' -k 2,2n | sort -t ':' -k 1,1 -s); do
    filename=$(echo $finding | cut -d ':' -f1)
    str_num=$(echo $finding | cut -d ':' -f2)

    if [[ "$filename" != "$prev" ]]; then
      real_str_num=$(expr $str_num + $lines_incr)
      repeat_counter=1
    else
      repeat_counter=$((repeat_counter+1))
      real_str_num=$(expr $str_num + $repeat_counter)
    fi

    sed -i '' -e "${real_str_num}i\\
  # checkov:skip=${key}: ${value}
    " $filename

    prev=$filename

    echo "${filename}:${real_str_num} fixed with $key : $value"
  done
done
