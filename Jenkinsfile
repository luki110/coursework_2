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
            steps
            {
                timeout(time: 1, unit: 'MINUTES')
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
    stage('Update kubernates')
    {
        ssh azureuser@168.61.219.5 kubectl set image deployments/luki-coursework2 luki-coursework2=szarlej110/coursework2:latest
    }
    
}
