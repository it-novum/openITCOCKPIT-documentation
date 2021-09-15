pipeline {
    agent any

    stages {
        when {
            branch 'master'
            not {
                changeRequest()
            }
        }
        stage('Build docker image') {
            steps {
                sh "docker build . -t openitcockpit/mkdocs"
            }
        }
        stage('Build and deploy') {
            steps {
                sh 'docker run --rm -it -v "$PWD":/docs -w /docs/de -p 8000:8000 openitcockpit/mkdocs /usr/bin/mkdocs build'
                sh 'docker run --rm -it -v "$PWD":/docs -w /docs/en -p 8000:8000 openitcockpit/mkdocs /usr/bin/mkdocs build'
                sh 'mkdir -p htdocs/en'
                sh 'cp -r de/site/. htdocs/'
                sh 'cp -r en/site/. htdocs/en'

                sh 'rsync -avz -e "ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/id_rsa" --progress --delete ./htdocs/. www-data@srvoitcdocs01.ad.it-novum.com:/var/www/docs.openitcockpit.io/'
            }
        }
    }

}
