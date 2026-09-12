# AWS X-Ray

## Reference
- [AWS X-Ray Developer Guide](https://docs.aws.amazon.com/xray/latest/devguide/aws-xray.html)


## How to use

AWS X-Ray is a distributed tracing service that helps you analyze and debug applications, especially those built using a microservices architecture.

`enable-xray.patch` turns the baseline [`sample-app`](../sample-app) into the X-Ray instrumented `sample-app-xray`, so the full API Gateway → Lambda → DynamoDB path shows up as a single trace.



### 1. Prerequisites

- Terraform >= 1.5 (the layer build uses `terraform_data`)
- `bash`, `python3`, and `pip` on the machine running `terraform apply` — the layer is built locally by a `local-exec` provisioner
- `patch` to apply the patch

### 2. Apply the patch

Copy sample app and apply patch.

```bash
cd 02.AWS_X-Ray
cp -R ../sample-app ./sample-app-xray
cd sample-app-xray
patch -p1 < ../enable-xray.patch 
```

### 3. Deploy

- Deploy with `terraform apply`
