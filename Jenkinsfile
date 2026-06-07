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
                catchError(buildResult: 'SUCCESS', stageResult:'FAILURE')
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
        // This script block dynamically adjusts recipient lists or subject lines based on status
        script{
           def emailSubject = "${currentBuild.currentResult}: Job '${env.JOB_NAME}' [BUILD #${env.BUILD_NUMBER}]";
           def recipientList = 'ashu.gajare@gmail.com';
            
                if (currentBuild.currentResult != 'SUCCESS')
                    { recipientList = 'ashu.gajare@gmail.com'}
                
        // Single execution block handling all outcomes (Success, Failure, Aborted, Unstable)
        emailext(
            subject: emailSubject,
            body: '${JELLY_SCRIPT, template="html"}',
            to: recipientList,
            mimeType: 'text/html'
        )
    
        archiveArtifacts artifacts: 'playwright-report/**', allowEmptyArchive:true
        allure includeProperties: false, jdk: '', results:[[path : 'allure-results']]
            }
        }
    }
}
    
