Current Status: pipeline is successfully doing:
Jenkins Enviornment variables-->BASEURL and CI=true
Install JDK for allure report commandline--->this will be removed and installed within docker image in the next commit
Checkout from GitHub-->stage(checkout scm)
Install dependencies-->stage(installing dependencies from package-lock.json-->playwright-report and allure-report)
Run Playwright tests-->stage(execute "npx playwright test" command on docker img)
Generate Allure report-->stage(overwrite existing allure-report)
Archive report-->stage(Artifact and Publish the HTML report in the build)
Send email-->stage(post action)
Clean up container--->this will be implemented in the next commit
