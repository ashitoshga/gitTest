pipeline{
    agent any
   /* triggers{
        cron 'H 1 * * *' //Schedule the job to run at 1 AM every day
    }*/
    tools{
        nodejs 'node' //Install nodeJs plugin
    }
    environment{
        BASE_URL = 'https://playwright.dev'
    }
    stages{

        stage('Checkout'){
            steps{
                checkout scm
            }
        }

        stage('Install Dependencies'){
            steps{
                sh 'npm ci'
                sh 'npm install --save-dev allure-playwright'
            }
        }

        stage('Install Playwright browsers'){
            steps{
                sh 'npx playwright install --with-deps'
            }
        }

        stage('Run Playwright tests'){
            steps{
                catchError(buildResult: 'Success', stageResult:'FAILURE')
                {
                    sh 'npx playwright test'
                }
                
            }
        }

        stage('Generate allure-report'){
            steps{
                sh 'npx allure generate allure-results -o allure-report'
            }
        }

    }

post{
    always{
        archiveArtifacts artifacts: 'playwright-report/**', allowEmptyArchive:true

        allure includeProperties: false, jdk: '', results:[[path : 'allure-results']]
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
