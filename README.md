# CloudCamp

Experiment with Cloudformation, running microservice
containerized

## AWS services explored

 - [Auto Scaling](https://aws.amazon.com/autoscaling)
 - [CodeBuild](https://aws.amazon.com/codebuild)
 - [CodePipeline](https://aws.amazon.com/codepipeline)
 - [CloudFormation](https://aws.amazon.com/cloudformation)
 - [EC2 Container Registry](https://aws.amazon.com/ecr/)
 - [EC2 Container Servier](https://aws.amazon.com/ecs/)
 - [Elastic Load Balancing](https://aws.amazon.com/elasticloadbalancing)

## Requirements

 - [AWS Command Line Interface](https://aws.amazon.com/cli/) (aws)

## Getting started

Create the whole setup with

    GitHubOAuthToken=xxxx make create-s3-stack create-stack

## Cleanup

    make delete-stack
    # note the s3 bucket stack will not be delete as
    # it will contain build files