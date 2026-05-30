On main branch:
Playwright.yml is created to install playwright browsers, allure-report, execute test, and artifact the results on a cloud machine.
Go to Actions>>Select the Playwright.yml
Run workflow manually to execute Playwright.yml on Github cloud runners

On AddingJenkinsFile branch:
Jenkinsfile is created to install playwright browsers, allure-report, execute test, and artifact the results on a local machine.
Go to Jenkins and run the "Playwright-Automation-pipeline" pipeline

On AddinDockerFile branch:
Dockerfile is created to install playwright browsers, allure-report, execute test, and artifact the results on a local machine.
Go to Jenkins and run the "Mulitbranch pipeline for Playwright Tests" pipeline
This branch will automatically scan for changes in the branch and look for Jenkinsfile to execute the test
#Plan is to execute the playwright test on the docker image
#Created a playwright docker image using Dockerfile and pushed into the dockerhub
#WIP--created a new folder "playwright_docker_image" folder to store the Dockerfile
#To build and run the docker image run this command:
"docker build -t playwright-tests_image:v3.0 . &&  docker run --name playwright-tests-container playwright-tests_image:v3.0"
#Pushed playwright image name is "ashitoshgajare/mydocker_repos:v1.0"
#It is Microsoft-playwright official image, on top of it has allure-report installed.
