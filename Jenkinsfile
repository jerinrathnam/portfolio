pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
        APPLICATION_NAME = 'portfoilo-app'
        DEPLOYMENT_GROUP = 'portfolio-deployment-group'
        S3_BUCKET = 'gemjerin-atlantis-tf-state'
        S3_KEY = 'portfolio/deployment.zip'
    }

    options {
        skipStagesAfterUnstable()
    }

    stages {
         stage('Clone repository') { 
            steps { 
                script{
                checkout scm
                }
            }
        }

        stage('Build') { 
            steps { 
                script{
                 app = docker.build("portfolio")
                }
            }
        }
        stage('Test'){
            steps {
                 echo 'Empty'
            }
        }
        stage('Push') {
            steps {
                script{
                        docker.withRegistry('https://521503820723.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:gem') {
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
                    }
                }
            }
        }

        stage('Zip the folder') {
            steps {
                sh "zip -r deployment.zip ."
            }
        }

        stage('Upload to S3') {
            environment {
                AWS_ACCESS_KEY_ID     = credentials('gem_aws_access_key')
                AWS_SECRET_ACCESS_KEY = credentials('gem_aws_secret_key')
            }
            steps {
                //withAWS(credentials: 'ecr:us-east-1:gem', region: AWS_DEFAULT_REGION) {
                    sh "aws s3 cp deployment.zip s3://$S3_BUCKET/$S3_KEY"
               // }
            }
        }
        stage('Deploy') {
            environment {
                AWS_ACCESS_KEY_ID     = credentials('gem_aws_access_key')
                AWS_SECRET_ACCESS_KEY = credentials('gem_aws_secret_key')
            }
            steps {
                //withAWS(credentials: 'ecr:us-east-1:gem', region: AWS_DEFAULT_REGION) {
                    sh "aws deploy create-deployment --application-name $APPLICATION_NAME --deployment-group-name $DEPLOYMENT_GROUP --s3-location bucket=$S3_BUCKET,key=$S3_KEY,bundleType=zip"
                //}
            }
        }
    }
}