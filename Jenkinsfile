pipeline{
    agent {
        docker {
            image 'ashitoshgajare/my-docker-playwright-img:latest'
            // Added host network and socket sharing so the internal container runs smoothly on macOS
            args '-v /var/run/docker.sock:/var/run/docker.sock -u root:root'       
            // Run the container as root to avoid permission issues when installing dependencies and running tests}
                }
        }     

    environment{
        BASE_URL = 'https://playwright.dev'
        CI = 'true'
    }

    
    stages{

        stage('Checkout'){
            steps{
                checkout scm
            }
        }

        stage('Run Playwright tests'){
            steps{
                catchError(buildResult: 'SUCCESS', stageResult:'FAILURE')
                {
                    sh 'npx playwright test'
                }
                
            }
        }

        stage('Generate allure-report'){
            steps{
                sh 'npx allure generate allure-results -o allure-report --clean'
                //overwwrite the previous report with --clean flag
            }
        }

    }

post{
    always{
         //allure plugin to publish allure report in Jenkins
        archiveArtifacts artifacts: 'playwright-report/**/*', allowEmptyArchive:true
        archiveArtifacts artifacts: 'allure-report/**/*', allowEmptyArchive: true
        //commented out allure plugin as it was giving some issues in Jenkins, so using publishHTML to publish allure report instead
       // allure includeProperties: false, jdk: '', results:[[path : 'allure-results']]
                  // Publishes the Playwright Report
            publishHTML([
                allowMissing: false,
                alwaysLinkToLastBuild: true,
                keepAll: true,
                reportDir: 'playwright-report',
                reportFiles: 'index.html',
                reportName: 'Playwright HTML Report'
            ])

            // Publishes the Allure Report that your container created
            publishHTML([
                allowMissing: false,
                alwaysLinkToLastBuild: true,
                keepAll: true,
                reportDir: 'allure-report',
                reportFiles: 'index.html',
                reportName: 'Allure HTML Report'
            ])
       
    }

    success {
            mail to: 'ashu.gajare@gmail.com',
                 subject: "SUCCESS: Job '${env.JOB_NAME}' (Build #${env.BUILD_NUMBER})",
                 body: "Great news! The Playwright automation tests passed successfully.\n\nView the execution details here: ${env.BUILD_URL}"
        }

    failure {
            mail to: 'ashu.gajare@gmail.com',
                 subject: "FAILURE: Job '${env.JOB_NAME}' (Build #${env.BUILD_NUMBER})",
                 body: "Attention: One or more Playwright tests failed in the pipeline.\n\nPlease check the console output and Allure logs here: ${env.BUILD_URL}"
        }
    }
}
