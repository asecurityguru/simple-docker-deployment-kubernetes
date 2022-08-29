pipeline {
  agent any
  tools { 
        maven 'Maven_3_8_5'  
    }
  environment {
        registry = "145988340565.dkr.ecr.us-west-2.amazonaws.com/asg"
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
//     stage('Docker Build and Push') {
//       steps {
//         withDockerRegistry([credentialsId: "dockerlogin", url: ""]) {
//           bat 'docker build -t asecurityguru/simple-app .'
//           bat 'docker push asecurityguru/simple-app'
//         }
//       }
//     }
     stage('Build') { 
            steps { 
               withDockerRegistry([credentialsId: "dockerlogin", url: ""]) {
                script{
                 app = docker.build("asg")
                }
               }
            }
        }
//       stage ("Build image") {
//             steps {
//                 withDockerRegistry([credentialsId: "dockerlogin", url: ""]) {
//                 script {
//                     docker.build registry
//                 }
//                 }
//             }
//         }
    stage('Push') {
            steps {
                script{
                    docker.withRegistry('https://145988340565.dkr.ecr.us-west-2.amazonaws.com', 'ecr:us-west-2:aws-credentials') {
                    app.push("latest")
                    }
                }
            }
        }
//     stage ("docker push") {
//          steps {
//              script {
//                 sh "aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 145988340565.dkr.ecr.us-west-2.amazonaws.com"
//                 sh "docker push 145988340565.dkr.ecr.us-west-2.amazonaws.com/asg"
                 
//              }
//            }   
//         }
    stage('Kubernetes Deployment - DEV') {
      steps {
        withKubeConfig([credentialsId: 'kubelogin']) {
          sh "kubectl apply -f deployment.yaml --namespace=test"
        }
      }
    }
  }
}
