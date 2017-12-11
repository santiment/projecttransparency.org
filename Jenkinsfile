podTemplate(label: 'projecttranparency-builder', containers: [
  containerTemplate(name: 'docker', image: 'docker', ttyEnabled: true, command: 'cat', envVars: [
    envVar(key: 'DOCKER_HOST', value: 'tcp://docker-host-docker-host:2375')
  ])
]) {
  node('projecttransparency-builder') {
    stage('Build image') {
      container('docker') {
        def scmVars = checkout scm
        // TODO: Add tests

        if (env.BRANCH_NAME == "master") {
          withCredentials([
            string(
              credentialsId: 'aws_account_id',
              variable: 'aws_account_id'
            )
          ]) {

            def awsRegistry = "${env.aws_account_id}.dkr.ecr.eu-central-1.amazonaws.com"
            docker.withRegistry("https://${awsRegistry}", "ecr:eu-central-1:ecr-credentials") {
              sh "docker build -t ${awsRegistry}/projecttransparency:${env.BRANCH_NAME} -t ${awsRegistry}/projecttransparency:${scmVars.GIT_COMMIT} ."
              sh "docker push ${awsRegistry}/projecttransparency:${env.BRANCH_NAME}"
              sh "docker push ${awsRegistry}/projecttransparency:${scmVars.GIT_COMMIT}"
            }
          }
        }
      }
    }
  }
}
