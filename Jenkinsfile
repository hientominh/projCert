node('master') {
    stage('Clone repository') { 
        script{
            checkout scm
        }
    }

    stage('provision test server'){
        sh 'cd docker-playbook && ansible-playbook install-playbook.yml -i inventory.txt'
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

node('slave') {
    currentBuild.result = "SUCCESS"

    try {
        stage('Pull') {
            script{
                    docker.withRegistry('https://index.docker.io/v1/', 'ed865ac2-f8ef-489f-ab77-11a816a18c78') {
                        app.pull("${env.BUILD_NUMBER}")
                        app.pull("latest")
                    }
            }
        }
        stage('deploy') {
            sh 'docker run -it -d -n phpapp tominhhien1/phpapp:latest'
        }
    }
    catch (err) {
        currentBuild.result = "FAILURE"
        stage('clean err') {
            sh 'docker stop phpapp && docker container rm phpapp'
        }
        throw err
    }
}