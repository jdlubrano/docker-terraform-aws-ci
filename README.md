# terraform-aws-ci Docker Image

A Docker image to build with Terraform and the AWS CLI on CI servers (like
Bitbucket or GitHub Actions)

## Using in a GitHub Action

This image can be used as the container in a GitHub action like this:

```yaml
jobs:
  my_job:
    runs-on: ubuntu-latest # Use Ubuntu to spin up the Action's Docker container
    container: jdlubrano/terraform-aws-ci:latest # Or use a stable v*.*.* tag
    steps:
      - uses: actions/checkout@v2
      - name: My Terraform step
        run: terraform init
      - name: My AWS CLI step
        run: aws --version
```

## Using in a Bitbucket Pipeline

This image can be used in a Bitbucket pipeline like this:

```yaml
image: jdlubrano/terraform-aws-ci:latest # Or use a stable v*.*.* tag

pipelines:
  default:
    - step:
        name: My Terraform step
        script:
          - terraform init
    - step:
        name: My AWS step
        script:
          - aws --version
```

You can, of course, also use this image for a specific build step, too:

```yaml
pipelines:
  default:
    - step:
        name: My Terraform and AWS steps
        image: jdlubrano/terraform-aws-ci:latest # Or use a stable v*.*.* tag
        script:
          - terraform init
          - aws --version
```
