pipeline 
{
    agent any
    
    triggers 
    {
        pollSCM('*/1 * * * *')
    }
    
    stages 
    {
        stage('Cleanup') 
        {
            steps 
            {
                //Removes Unnseecessary files
                echo 'Performing cleanup...'
                sh 'rm -rf *'
            }
        }
        
        stage('Clone') 
        {
            steps
            {
                //clonning from github to workspace
                echo 'Cloning repository...'
                sh 'git clone https://github.com/S0ulTak3r/flask.git'
                sh 'ls'
            }
        }
        
        stage('Build') 
        {
            steps 
            {
                //stage building
                echo 'Building...'
                echo 'Packaging...'
                sh 'tar -czvf FlaskProject.tar.gz flask'
                sh 'ls'
            }
        }
        
        stage('Upload to S3') 
        {
            steps 
            {
                //upload project to s3
                sh 'aws s3 cp FlaskProject.tar.gz s3://daniel-sela/FlaskJenkins/'
            }
        }

        stage('Get Test+Prod Instance Details')
        {
            steps 
            {
                //pulls IP of test instance by automatical means
                script 
                {
                    def instanceTestId = sh(script: "aws ec2 describe-instances --region eu-north-1 --filters 'Name=tag:servernumber,Values=flask1' 'Name=instance-state-name,Values=stopped' | jq -r .Reservations[].Instances[].InstanceId", returnStdout: true).trim()
                    def instanceProdId = sh(script: "aws ec2 describe-instances --region eu-north-1 --filters 'Name=tag:servernumber,Values=flask2' 'Name=instance-state-name,Values=stopped' | jq -r .Reservations[].Instances[].InstanceId", returnStdout: true).trim()
                    
                    if(instanceTestId)
                    {
                        //Test Not Running
                        sh (script: "aws ec2 start-instances --region eu-north-1 --instance-ids ${instanceTestId}")
                        sh (script: "aws ec2 wait instance-running --region eu-north-1 --instance-ids ${instanceTestId}")
                    }
                    else
                    {
                        //Gather Id with Running state
                        instanceTestId= sh(script: "aws ec2 describe-instances --region eu-north-1 --filters 'Name=tag:servernumber,Values=flask1' 'Name=instance-state-name,Values=running' | jq -r .Reservations[].Instances[].InstanceId", returnStdout: true).trim()
                    }
                    def publicTestIp = sh(script: "aws ec2 describe-instances --region eu-north-1 --instance-ids ${instanceTestId} | jq -r .Reservations[].Instances[].PublicIpAddress", returnStdout: true).trim()
                    env.instanceTestId = instanceTestId
                    env.publicTestIp = publicTestIp


                    if(instanceProdId)
                    {
                        //prod not running
                        sh (script: "aws ec2 start-instances --region eu-north-1 --instance-ids ${instanceProdId}")
                        sh (script: "aws ec2 wait instance-running --region eu-north-1 --instance-ids ${instanceProdId}")
                    }
                    else
                    {
                        //Gather Id with Running state
                        instanceProdId= sh (script: "aws ec2 describe-instances --region eu-north-1 --filters 'Name=tag:servernumber,Values=flask2' 'Name=instance-state-name,Values=running' | jq -r .Reservations[].Instances[].InstanceId", returnStdout: true).trim()
                    }
                    def publicProdIp =sh(script: "aws ec2 describe-instances --region eu-north-1 --instance-ids ${instanceProdId} | jq -r .Reservations[].Instances[].PublicIpAddress", returnStdout: true).trim() 
                    env.instanceProdId=instanceProdId
                    env.publicProdIp=publicProdIp
                }
            }
        }

        stage('Pull gzip from S3 to Test Server') 
        {
            steps 
            {
                sh "ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/Daniel.pem ec2-user@${env.publicTestIp} 'aws s3 cp s3://daniel-sela/FlaskJenkins/FlaskProject.tar.gz .'"
            }
        }

        stage('Run Script On Test-Start the Project') 
        {
            steps 
            {
                sh "scp -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/Daniel.pem /var/lib/jenkins/scripts/script.sh ec2-user@${env.publicTestIp}:~/"
                sh "ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/Daniel.pem ec2-user@${env.publicTestIp} 'bash -xe ~/script.sh'"
            }
        }

        stage('Test') 
        {
            steps 
            {
                sh "curl http://${env.publicTestIp}:5000"
            }
        }
        
        stage('Closing test server- if success') {
            steps 
            {
                sh "aws ec2 stop-instances --region eu-north-1 --instance-ids ${env.instanceTestId}"
                sh "aws ec2 wait instance-stopped --region eu-north-1 --instance-ids ${env.instanceTestId}"
            }
        }


        
        stage('Deployment') {
            steps 
            {
                sh "ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/Daniel.pem ec2-user@${env.publicProdIp} 'aws s3 cp s3://daniel-sela/FlaskJenkins/FlaskProject.tar.gz .'"
                sh "scp -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/Daniel.pem /var/lib/jenkins/scripts/script.sh ec2-user@${env.publicProdIp}:~/"
                sh "ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/Daniel.pem ec2-user@${env.publicProdIp} 'bash -xe ~/script.sh'"
            }
        }
    }
}
