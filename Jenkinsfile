pipeline 
{
    agent any
    environment
    {
        CI = 'true'
    }
    stages
    {
       stage('SonarQube')
       {
            environment
            {
                scannerHome = tool 'SonarQubeScanner'
            }
            steps 
            {
                withSonarQubeEnv('SonarQube')
                {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
	stage("Quality Gate") 
        {
            timeout(time: 1, unit: 'MINUTES') 
            { // Just in case something goes wrong, pipeline will be killed after a timeout
                def qg = waitForQualityGate() // Reuse taskId previously collected by withSonarQubeEnv
                if (qg.status != 'OK')
                {
                    error "Pipeline aborted due to quality gate failure: ${qg.status}"
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
