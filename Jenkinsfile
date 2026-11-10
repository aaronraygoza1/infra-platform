pipeline {
  agent any

  parameters {
    choice(name: 'ENV', choices: ['azure-dev']: 'Ambiente')
  }

  environment {
    ARM_CLIENT_ID       = credentials('az-client-id')
    ARM_CLIENT_SECRET   = credentials('az-client-secret')
    ARM_TENANT_ID       = credentials('az-tenant-id')
    ARM_SUBSCRIPTION_ID = credentials('az-subscription-id')
    TF_IN_AUTOMATION    = 'true'
  }

  stages {
    stage('Init') {
      steps {
        dir("environments/${params.ENV}") {
          sh 'terraform init -input=false'
        }
      }
    }

    stage('Validate') {
      steps {
        dir("environments/${params.ENV}") {
          sh 'terraform validate'
        }
      }
    }

    stage('Plan') {
      steps {
        dir("environments/${params.ENV}") {
          sh "terraform plan -input=false -var-file=${params.ENV}.tfvars -out=tfplan"
        }
      }
    }

    stage('Aprobación') {
      steps {
        timeout(time: 30, unit: 'MINUTES') {
          input message: 'Revisaste el plan? Aplicar?'
        }
      }
    }

    stage('Apply') {
      steps {
        dir("environments/${params.ENV}") {
          sh 'terraform apply -input=false tfplan'
        }
      }
    }

    stage('Deploy K8s') {
      steps {
        withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
          sh 'kubectl get nodes'
          sh 'kubectl apply -f k8s/'
          sh 'kubectl get pods'
        }
      }
    }
  }

  post {
    failure { echo 'Falló: revisa el log del stage en rojo' }
    always  { cleanWs() }
  }
}