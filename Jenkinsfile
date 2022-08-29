pipeline {
  agent any
  tools { 
        maven 'Maven_3_8_5'  
    }

  stages {
//     stage('Build Artifact - Maven') {
//       steps {
//         bat "mvn clean package -DskipTests=true"
//         archive 'target/*.jar'
//       }
//     }

//     stage('Unit Tests - JUnit and Jacoco') {
//       steps {
//         bat "mvn test"
//       }
//     }
    stage('Docker Build and Push') {
      steps {
        withDockerRegistry([credentialsId: "dockerlogin", url: ""]) {
          bat 'docker build -t asecurityguru/simple-app .'
          bat 'docker push asecurityguru/simple-app'
        }
      }
    }
     stage('Build') { 
            steps { 
                script{
                 app = docker.build("octopus-underwater-app")
                }
            }
        }
    stage('Push') {
            steps {
                script{
                    docker.withRegistry('https://public.ecr.aws/t4f4l9c8/asg', 'ecr:us-west-2:aws-credentials') {
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
                    }
                }
            }
        }
    stage('Kubernetes Deployment - DEV') {
      steps {
        withKubeConfig([credentialsId: 'kubelogin']) {
          bash "kubectl apply -f deployment.yaml"
        }
      }
    }
  }
}
