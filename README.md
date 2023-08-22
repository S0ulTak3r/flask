Daniel's Flask Project
Introduction
Welcome to the deployment and management guide for Daniel's Flask project. This project is currently set up with two main pipelines: Jenkinsfile-dockercompose2 and Jenkinsfile-kubernetes-WIP. The Google site runs on Kubernetes, while the Jenkins docker-compose operates on AWS.

Prerequisites
Before diving in, ensure you have:

Jenkins on a VM or another preferred machine.
Kubernetes on a Cloud (Optional for Kubernetes pipeline).
Docker-for-desktop with Kubernetes installed (For Kubernetes pipeline).
SSH connection to the VM hosting Jenkins.
An AWS account with appropriate user permissions.
Repositories
Shared Library Repo for functions: PipelineFunctions

Ansible Files Repo: Daniel-B-AutoAnsible. For better management, a custom folder in /var/lib/jenkins holds this repo, e.g., /var/lib/jenkins/AnsibleFiles/Daniel-B-AutoAnsible.

Deployment Instructions
Kubernetes Pipeline:
Ensure Jenkins has DockerLogin Credentials ID for storing username + password.
Create and configure an Ansible folder.
Set up Docker-for-desktop.
Establish an SSH connection.
Install and configure the gcloud-gke-auth plugin.
Add cluster details to kubectl config file.
Update the Kubernetes pipeline.
Dockercompose2 Pipeline:
Set up AWS Configuration.
Create and configure the Ansible folder.
Update the Ansible Configuration.
Set up the SSH .PEM KEY.
Directory Structure
The project's directory structure is as follows:

(Your directory structure here)

Tips and Best Practices
Adherence to best practices is essential for a smooth deployment.
Always refer back to this guide when in doubt.
Conclusion
Thank you for using Daniel's Flask Project. For any clarifications or issues, please reach out. Your feedback is invaluable.