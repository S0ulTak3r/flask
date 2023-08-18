# Daniel's Flask Project
# Introduction
This document serves as a comprehensive guide to deploying and managing the Flask project of Daniel. Before proceeding, please ensure you have both Jenkins and a Kubernetes environment at your disposal.

The subsequent sections will discuss in detail the connection process and how to configure Jenkins files for different types of deployments. You'll also be guided to adjust the environment variables as needed.

# Prerequisites
To run the Flask Project, the following prerequisites should be met:

Jenkins On A VM (or other machine of choice)

Kubernetes On A Cloud ---> Optional, only if using the kubernetes pipeline, although you can tailor it to only use the docker-for-desktop one, aka remove the production steps.

Docker-for-desktop ---> yet again, only if you are using the kubernetes pipeline (make sure you installed kubernetes on it)

SSH connection with the VM that is hosting Jenkins (To Enable The Proxy On Windows, although you can run it manually and remove the proxy steps)
s

AWS account and user permissions

# Deployment Instructions
# Kubernetes Pipeline:

Ensure Jenkins Has DockerLogin Credentials ID, that will store you username + password

Create and Configure Ansible Folder: You'll need to manually create an Ansible folder, git clone the relevant Ansible files repository, and update the environment variable in the pipeline.

Setup Docker-for-desktop: Ensure Docker-for-desktop is running and Kubernetes is installed.

SSH Connection: Ensure that you have an SSH connection with the Windows machine hosting your Jenkins-running VM. (option: remove the proxy steps, and just run it manually or as a service on windows)

Install and configure the gcloud-gke-auth plugin: After installing the plugin, add the relevant details to /etc/bash.bashrc on the machine hosting the jenkins.

Add cluster details to kubectl config file: Use the following command to add the relevant cluster details: gcloud container clusters get-credentials CLUSTER_NAME --region=COMPUTE_REGION.

Update Kubernetes pipeline: Make sure to update the relevant sections of the pipeline, being AnsibleFolder and so on, aswell as update the ansible.cfg to find the .pem file that should be in /var/lib/jenkins/.ssh, with permissions 400 or 600.

# Dockercompose2 Pipeline:

AWS Configuration: Ensure aws configure is set on the Jenkins user with the appropriate user permissions.

Create and Configure Ansible Folder: You'll need to manually create an Ansible folder, git clone the relevant Ansible files repository, and update the environment variable in the pipeline.

Update Ansible Configuration: Make sure to update your ansible.cfg to match your .pem key file name used to connect via SSH to the relevant instances. Ensure it has 600 or 400 permission.

SSH .PEM KEY: Update the environment variable sshfilepath and as a good practice, keep it in /var/lib/jenkins/.ssh.

# Tips and Best Practices
Adherence to best practices ensures smooth deployment and management of the Flask project. We highly recommend following all the instructions diligently to avoid unexpected issues.

# Conclusion
Thank you for using Daniel's Flask Project. Please refer to this document when needed, and don't hesitate to ask if you encounter any issues or if something is unclear. We appreciate your contribution and cooperation.