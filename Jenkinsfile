node('master') {
    stage('Clone repository') { 
        script{
            checkout scm
        }
    }

    stage('Build') { 
        script{
            app = docker.build("tominhhien1/phpapp")
        }
    }
    stage('Push') {
        script{
                docker.withRegistry('https://index.docker.io/v1/', 'ed865ac2-f8ef-489f-ab77-11a816a18c78') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
            }
        }
    }

}