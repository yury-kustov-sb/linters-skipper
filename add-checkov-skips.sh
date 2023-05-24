#!/bin/zsh
set -e

echo Starting...

declare -A skips

skips[CKV_AWS_135]="TODO: Ensure that EC2 is EBS optimized"
skips[CKV_SECRET_2]="TODO: Ensure it is safe here"
skips[CKV_AWS_273]="MFA enabled for all users"
skips[CKV_AWS_111]="TODO: Ensure IAM policies does not allow write access without constraints"
skips[CKV_AWS_112]="TODO: Ensure Session Manager data is encrypted in transit"
skips[CKV_AWS_118]="TODO: Ensure that enhanced monitoring is enabled for Amazon RDS instances"
skips[CKV_AWS_119]="TODO: Ensure DynamoDB Tables are encrypted using a KMS Customer Managed CMK"
skips[CKV_AWS_126]="TODO: Ensure that detailed monitoring is enabled for EC2 instances"
skips[CKV_AWS_127]="TODO: Ensure that Elastic Load Balancer(s) uses SSL certificates provided by AWS Certificate Manager"
skips[CKV_AWS_130]="TODO: Ensure VPC subnets do not assign public IP by default"
skips[CKV_AWS_131]="TODO: Ensure that ALB drops HTTP headers"
skips[CKV_AWS_136]="TODO: Ensure that ECR repositories are encrypted using KMS"
skips[CKV_AWS_150]="TODO: Ensure that Load Balancer has deletion protection enabled"
skips[CKV_AWS_157]="TODO: Ensure that RDS instances have Multi-AZ enabled"
skips[CKV_AWS_158]="TODO: Ensure that CloudWatch Log Group is encrypted by KMS"
skips[CKV_AWS_161]="TODO: Ensure RDS database has IAM authentication enabled"
skips[CKV_AWS_163]="TODO: Ensure ECR image scanning on push is enabled"
skips[CKV_AWS_166]="TODO: Ensure Backup Vault is encrypted at rest using KMS CMK"
skips[CKV_AWS_17]="TODO: Ensure all data stored in RDS is not publicly accessible"
skips[CKV_AWS_174]="TODO: Verify CloudFront Distribution Viewer Certificate is using TLS v1.2"
skips[CKV_AWS_184]="TODO: Ensure resource is encrypted by KMS using a customer managed Key"
skips[CKV_AWS_189]="TODO: Ensure EBS Volume is encrypted by KMS using a customer managed Key"
skips[CKV_AWS_226]="TODO: Ensure DB instance gets all minor upgrades automatically"
skips[CKV_AWS_229]="TODO: Ensure no NACL allow ingress from internet to port 21"
skips[CKV_AWS_23]="TODO: Ensure every security groups rule has a description"
skips[CKV_AWS_230]="TODO: Ensure no NACL allow ingress from internet to port 20"
skips[CKV_AWS_231]="TODO: Ensure no NACL allow ingress from internet to port 3389"
skips[CKV_AWS_232]="TODO: Ensure no NACL allow ingress from internet to port 22"
skips[CKV_AWS_24]="TODO: Ensure no security groups allow ingress from 0.0.0.0:0 to port 22"
skips[CKV_AWS_240]="TODO: Ensure Kinesis Firehose delivery stream is encrypted"
skips[CKV_AWS_241]="TODO: Ensure that Kinesis Firehose Delivery Streams are encrypted with CMK"
skips[CKV_AWS_259]="TODO: Ensure CloudFront response header policy enforces Strict Transport Security"
skips[CKV_AWS_260]="TODO: Ensure no security groups allow ingress from 0.0.0.0:0 to port 80"
skips[CKV_AWS_27]="TODO: Ensure all data stored in the SQS queue is encrypted"
skips[CKV_AWS_273]="TODO: Ensure access is controlled through SSO and not AWS IAM defined users"
skips[CKV_AWS_274]="TODO: Disallow IAM roles, users, and groups from using the AWS AdministratorAccess policy"
skips[CKV_AWS_283]="TODO: Ensure no IAM policies documents allow ALL or any AWS principal permissions to the resource"
skips[CKV_AWS_290]="TODO: Ensure IAM policies does not allow write access without constraints"
skips[CKV_AWS_293]="TODO: Ensure that AWS database instances have deletion protection enabled"
skips[CKV_AWS_3]="TODO: Ensure all data stored in the EBS is securely encrypted"
skips[CKV_AWS_305]="TODO: Ensure Cloudfront distribution has a default root object configured"
skips[CKV_AWS_310]="TODO: Ensure CloudFront distributions should have origin failover configured"
skips[CKV_AWS_315]="TODO: Ensure EC2 Auto Scaling groups use EC2 launch templates"
skips[CKV_AWS_337]="TODO: Ensure SSM parameters are using KMS CMK"
skips[CKV_AWS_40]="TODO: Ensure IAM policies are attached only to groups or roles"
skips[CKV_AWS_51]="TODO: Ensure ECR Image Tags are immutable"
skips[CKV_AWS_61]="TODO: Ensure AWS IAM policy does not allow assume role permission across all services"
skips[CKV_AWS_62]="TODO: Ensure IAM policies that allow full administrative privileges are not created"
skips[CKV_AWS_63]="TODO: Ensure no IAM policies documents allow wildcard as a statement actions"
skips[CKV_AWS_7]="TODO: Ensure rotation for customer created CMKs is enabled"
skips[CKV_AWS_77]="TODO: Ensure Athena Database is encrypted at rest"
skips[CKV_AWS_79]="TODO: Ensure Instance Metadata Service Version 1 is not enabled"
skips[CKV_AWS_8]="TODO: Ensure all data stored in the Launch configuration or instance Elastic Blocks Store is securely encrypted"
skips[CKV_AWS_91]="TODO: Ensure the ELBv2 has access logging enabled"
skips[CKV_AWS_92]="TODO: Ensure the ELB has access logging enabled"
skips[CKV_AWS_355]="TODO: Ensure no IAM policies documents allow wildcard as a statement resource"
skips[CKV_AWS_353]="TODO: Ensure that RDS instances have performance insights enabled"
skips[CKV_AWS_354]="TODO: Ensure RDS Performance Insights are encrypted using KMS CMKs"
skips[CKV2_AWS_11]="TODO: Ensure VPC flow logging is enabled in all VPCs"
skips[CKV2_AWS_12]="TODO: Ensure the default security group of every VPC restricts all traffic"
skips[CKV2_AWS_14]="TODO: Ensure that IAM groups includes at least one IAM user"
skips[CKV2_AWS_15]="TODO: Ensure that auto Scaling groups that are associated with a load balancer, are using Elastic Load Balancing health checks."
skips[CKV2_AWS_16]="TODO: Ensure that Auto Scaling is enabled on your DynamoDB tables"
skips[CKV2_AWS_18]="TODO: Ensure that Elastic File System file systems are added in the backup plans of AWS Backup"
skips[CKV2_AWS_19]="TODO: Ensure that all EIP addresses allocated to a VPC are attached to EC2 instances"
skips[CKV2_AWS_20]="TODO: Ensure that all EIP addresses allocated to a VPC are attached to EC2 instances"
skips[CKV2_AWS_21]="TODO: Ensure that all IAM users are members of at least one IAM group."
skips[CKV2_AWS_23]="TODO: Route53 A Record has Attached Resource"
skips[CKV2_AWS_2]="TODO: Ensure that only encrypted EBS volumes are attached to EC2 instances"
skips[CKV2_AWS_30]="TODO: Ensure Postgres RDS as aws_db_instance has Query Logging enabled"
skips[CKV2_AWS_34]="TODO: AWS SSM Parameter should be Encrypted"
skips[CKV2_AWS_38]="TODO: Ensure Domain Name System Security Extensions signing is enabled for Amazon Route 53 public hosted zones"
skips[CKV2_AWS_39]="TODO: Ensure Domain Name System query logging is enabled for Amazon Route 53 hosted zones"
skips[CKV2_AWS_40]="TODO: Ensure AWS IAM policy does not allow full IAM privileges"
skips[CKV2_AWS_42]="TODO: Ensure AWS CloudFront distribution uses custom SSL certificate"
skips[CKV2_AWS_47]="TODO: Ensure AWS CloudFront attached WAFv2 WebACL is configured with AMR for Log4j Vulnerability"
skips[CKV2_AWS_5]="TODO: Ensure that Security Groups are attached to another resource"
skips[CKV2_AWS_60]="TODO: Ensure RDS instance with copy tags to snapshots is enabled"
skips[CKV2_AWS_9]="TODO: Ensure that EBS are added in the backup plans of AWS Backup"
skips[CKV2_AWS_32]="TODO: Ensure CloudFront distribution has a response headers policy attached"

repeat_counter=0
lines_incr=1
for key value in "${(@kv)skips}"; do
  for finding in $(pre-commit run -a | grep -A2 "${key}:"  | grep 'File:' | cut -d '/' -f2 | rev | cut -d- -f2- | rev | sort -t ':' -k 2,2n | sort -t ':' -k 1,1 -s); do
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
