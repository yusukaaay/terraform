# Service1作成

## 前提条件

1. CI/CD アカウントの IAM ユーザでログインしていること

1. AWS CLI config にクロスアカウントロールを使用する profile が登録されていること

```awsconfig
[default]
output = json
region = ap-northeast-1

[profile dev-cicd-cross-accounts]
role_arn = arn:aws:iam::XXXXXXXXXXXX:role/nnnn-nnnnn-nnnnnnn
source_profile = default

[profile stg-cicd-cross-accounts]
role_arn = arn:aws:iam::XXXXXXXXXXXX:role/nnnn-nnnnn-nnnnnnn
source_profile = default

[profile prd-cicd-cross-accounts]
role_arn = arn:aws:iam::XXXXXXXXXXXX:role/nnnn-nnnnn-nnnnnnn
source_profile = default

```

### 環境ごとのディレクトリに移動

例) DEV 環境

```bash
cd terraform/service1/env/dev
```

### 環境構築

```bash
terraform plan
terraform apply
```

