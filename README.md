# Daniel's Flask Project

## Introduction

Welcome to the deployment and management guide for Daniel's Flask project. This project is currently set up with two main pipelines: `Jenkinsfile-dockercompose2` and `Jenkinsfile-kubernetes-WIP`. The Google site runs on Kubernetes, while the Jenkins docker-compose operates on AWS.

## Prerequisites

Before diving in, ensure you have:

- Jenkins on a VM or another preferred machine.
- Kubernetes on a Cloud (Optional for Kubernetes pipeline).
- Docker-for-desktop with Kubernetes installed (For Kubernetes pipeline).
- SSH connection to the VM hosting Jenkins.
- An AWS account with appropriate user permissions.

## Repositories

- Shared Library Repo for functions: [PipelineFunctions](https://github.com/S0ulTak3r/PipelineFunctions)
- Ansible Files Repo: [Daniel-B-AutoAnsible](https://github.com/S0ulTak3r/Daniel-B-AutoAnsible). For better management, a custom folder in `/var/lib/jenkins` holds this repo, e.g., `/var/lib/jenkins/AnsibleFiles/Daniel-B-AutoAnsible`.

## Deployment Instructions

### Kubernetes Pipeline:

1. Ensure Jenkins has DockerLogin Credentials ID for storing username + password.
2. Create and configure an Ansible folder.
3. Set up Docker-for-desktop.
4. Establish an SSH connection.
5. Install and configure the `gcloud-gke-auth` plugin.
6. Add cluster details to `kubectl` config file.
7. Update the Kubernetes pipeline.

### Dockercompose2 Pipeline:

1. Set up AWS Configuration.
2. Create and configure the Ansible folder.
3. Update the Ansible Configuration.
4. Set up the SSH .PEM KEY.

## Directory Structure

The project's directory structure is as follows:

.
├── docker-compose-prod.yml
├── docker-compose-test.yml
├── flask-app
│   ├── app.py
│   ├── Dockerfile
│   ├── __pycache__
│   │   └── app.cpython-310.pyc
│   ├── requirements.txt
│   ├── Static
│   │   ├── CSS
│   │   │   ├── intro.css
│   │   │   ├── portfolio.css
│   │   │   └── second_intro.css
│   │   ├── IMG
│   │   │   ├── computer.jpg
│   │   │   └── psycho.png
│   │   ├── JS
│   │   │   ├── portfolio.js
│   │   │   └── second_intro.js
│   │   ├── ResumeDanielBoguslavsky.pdf
│   │   ├── SCSS
│   │   │   └── portfolio.scss
│   │   └── UnityBuild
│   │       ├── Build
│   │       │   ├── sss.data.gz
│   │       │   ├── sss.framework.js.gz
│   │       │   ├── sss.loader.js
│   │       │   └── sss.wasm.gz
│   │       ├── index.html
│   │       └── TemplateData
│   │           ├── favicon.ico
│   │           ├── fullscreen-button.png
│   │           ├── MemoryProfiler.png
│   │           ├── progress-bar-empty-dark.png
│   │           ├── progress-bar-empty-light.png
│   │           ├── progress-bar-full-dark.png
│   │           ├── progress-bar-full-light.png
│   │           ├── style.css
│   │           ├── unity-logo-dark.png
│   │           ├── unity-logo-light.png
│   │           ├── webgl-logo.png
│   │           └── webmemd-icon.png
│   └── Web
│       ├── gifs.html
│       ├── intro.html
│       ├── portfolio.html
│       ├── second_intro.html
│       └── welcome.html
├── Jenkinsfile
├── Jenkinsfile-docker
├── Jenkinsfile-dockercompose2
├── Jenkinsfile-kubernetes-WIP
├── KubernetesFiles
│   ├── deployment.yml
│   ├── servicedeployment.yml
│   └── service.yml
├── LearningPurpose
│   ├── 36002.gif
│   ├── computer.jpg
│   ├── intro.css
│   ├── intro.html
│   ├── portfolio.css
│   ├── portfolio.html
│   ├── portfolio.js
│   ├── psycho.png
│   ├── ResumeDanielBoguslavsky.pdf
│   ├── ss
│   │   └── portfolio.css
│   ├── sss
│   └── TerraFormLearning
│       ├── TerraformLesson1
│       │   └── main.tf
│       └── TerraformLesson2
│           ├── ansible.cfg
│           ├── docker-compose.yml
│           ├── installLocalTerraformTest.yml
│           ├── main.tf
│           ├── terraform.tfstate
│           └── terraform.tfstate.backup
├── mynewchart
│   ├── Chart.lock
│   ├── charts
│   │   ├── grafana-6.58.8.tgz
│   │   └── prometheus-23.3.0.tgz
│   ├── Chart.yaml
│   ├── templates
│   │   ├── deployment.yml
│   │   └── service.yaml
│   └── values.yaml
├── mysql
│   ├── Dockerfile
│   └── sql-scripts
│       └── 1_init.sql
├── prometheusconfig.yml
├── README.md
├── scripts
│   └── versionBump.sh
└── TerraformFiles
    └── GKE.tf


## Tips and Best Practices

- Adherence to best practices is essential for a smooth deployment.
- Always refer back to this guide when in doubt.

## Conclusion

Thank you for using Daniel's Flask Project. For any clarifications or issues, please reach out. Your feedback is invaluable.
