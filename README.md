# Provision AWS Infrastructure Using Terraform and automate Security Scanning for Iac

## Project Details
**Part 1**: Automate entire process of provisioning EC2 servers, AWS networking resources, IAM roles & permissions using Terraform
**Part 2**: Create a GitLab CI/CD pipeline for Terraform Infrastructure with built-in security scanning and code validation - GitOps


## Table of contents

- [Technologies used](#Technologies-Used)
- [Project Description](#Project-Description)
- [Terraform Configuration](#Terraform-Configuration)
- [Initial Project](Initial-Project)
- [Contributors](#contributors)
- [Licensing](#licensing)

## Technologies Used
Terraform, Docker, Git, AWS (VPC, EC2, IAM, S#), GitLab CI, TFSec

## Project Description:
**Part 1**
- Create new IAM user for Terraform operations
- Create IAM roles with needed policies for application server and GitLab runner instances. Resources created with the TF script:
    - role "app-server-role" with policies:
        - AmazonSSMManagedInstanceCore
        - AmazonEC2ContainerRegistryFullAccess
    - role "gitlab-runner-role" with policies:
        - AmazonSSMFullAccess
        - AmazonEC2ContainerRegistryFullAccess
- Create VPC with public and private subnets. Resource created with the TF script:
    - vpc "main"
- Create VPC and Security Group resources for EC2 networking. Resource created with the TF script:
    - security group "main"
    - security group "app-server"
- Create and configure two EC2 instances:
    - Create application server with secure firewall configuration. Resource created:
        - ec2 server "ec2_app_server" with:
            - Role: app-server-role
            - Security Group: app-server
    - Configure script to automatically install Docker and application dependencies on the application server 
    - Create GitLab CI server with secure firewall configuration. Resource created:
        - ec2 server "ec2_gitlab_runner"
            - Role: gitlab-runner-role
            - Security Group: main
    - Configure script to automatically install Docker and register the instance as a GitLab runner


**Part 2**
- Create AWS S3 bucket and configure Terraform to use bucket for storing Terraform state
- Create new GitLab CI pipeline for Terraform infrastructure that:
    - Initializes Terraform and builds a plan artifact 
    - Validates Terraform configuration and syntax
    - Runs a TFSec security scan on Terraform code and produces scan result artifact
    - Deploys the Terraform code to AWS


## Terraform Configuration
- providers:
    - hashicorp/aws = 5.3
- modules:
    - terraform-aws-modules/ec2-instance/aws = 5.2.1
    - terraform-aws-modules/vpc/aws = 5.1.0
    
Terraform commands to execute the script:
- initialise project & download providers
    - *terraform init* 
- preview what will be created with apply & see if any errors
    - *terraform plan*
- exeucute with preview
    - *terraform apply -var-file terraform.tfvars*
- execute without preview
    - *terraform apply -var-file terraform.tfvars -auto-approve*
- destroy everything
    - *terraform destroy*
- show resources and components from current state
    - *terraform state list*

Notes: 
- Create terraform.tfvars file, make sure *.tfvars is in your .gitigonore file, and set following variables inside before running the script:
    - aws_access_key_id
    - aws_secret_access_key
    - aws_region
    - env_prefix
    - runner_registration_token from adding runner to CI/CD project mentionned in initial project
- For verbose output, set export TF_LOG=DEBUG before running TF commands

## Initial Project
This project build on previous one: 
![GitHub](https://github.com/Nicole732/devsecops-sast-dast-gitlab-cicd)
It uses OAWSP Juice Shop vulnerable application as the application code:
[![Juice Shop Screenshot Slideshow](https://img.shields.io/github/release/juice-shop/juice-shop.svg)](https://github.com/juice-shop/juice-shop/releases/latest)

**Part 2**


## Contributors

The contributors to this project are:
- [Tech World by NaNa](https://www.techworld-with-nana.com/devsecops-bootcamp) 

## Licensing

This program is free software: you can redistribute it and/or modify it under the terms of the [MIT license](LICENSE).
