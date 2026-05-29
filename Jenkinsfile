pipeline{

    //Updated the agent configuration from 'any' to use a specific label and Docker image for Playwright testing
    agent 
    {
        docker{
            image 'mcr.microsoft.com/playwright:v1.60.0-jammy' //Use the Playwright Docker image as the build environment
            label 'playwright-agent' //Specify the agent label to run the pipeline on a specific nod
            args '-v /tmp:/tmp --init' //
            }
    }

    triggers{
        cron 'H 1 * * *' //Schedule the job to run at 1 AM every day
    }

    //Removed the 'tools' block as it is not necessary when using a Docker image that already has Node.js installed
    //Add CI environment variable to indicate that the tests are running in a CI environment, which can help with test reporting and behavior

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

        stage('Install Dependencies'){
            steps{
                sh 'npm ci'
                sh 'npm install --save-dev allure-playwright'
            }
        }

        //Removed Install Browsers stage as the Playwright Docker image already includes the necessary browsers
        // Pre-installed browsers in the v1.60.0 image will launch immediately

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
