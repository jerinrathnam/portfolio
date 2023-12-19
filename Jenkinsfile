pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
        APPLICATION_NAME = 'portfolio-app'
        DEPLOYMENT_GROUP = 'portfolio-deployment-group'
        S3_BUCKET = 'codepipeline-us-east-1-655442461495'
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
                //def folderToZip = '.'
                sh "zip -r deployment.zip ."
            }
        }

        stage('Upload to S3') {
            steps {
                withAWS(credentials: 'ecr:us-east-1:gem', region: AWS_DEFAULT_REGION) {
                    sh "aws s3 cp deployment.zip s3://$S3_BUCKET/$S3_KEY"
                }
            }
        }
        stage('Deploy') {
            steps {
                withAWS(credentials: 'ecr:us-east-1:gem', region: AWS_DEFAULT_REGION) {
                    sh "aws deploy create-deployment --application-name $APPLICATION_NAME --deployment-group-name $DEPLOYMENT_GROUP --s3-location bucket=$S3_BUCKET,key=$S3_KEY,bundleType=zip"
                }
            }
        }
    }
}