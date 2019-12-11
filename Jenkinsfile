pipeline 
{
    agent any
    environment
    {
        CI = 'true'
    }
    stages
    {
       stage('Sonarqube')
       {
            environment
            {
                scannerHome = tool 'SonarQubeScanner'
            }
            steps 
            {
                withSonarQubeEnv('sonarqube')
                {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
                timeout(time: 10, unit: 'MINUTES')
                {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }
}
node {
    def app

    stage('Clone repository')
    {

        checkout scm
    }

    stage('Build image') 
    {
        
        app = docker.build("szarlej110/coursework2")
    }


    stage('Push image') 
    {        
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
}
