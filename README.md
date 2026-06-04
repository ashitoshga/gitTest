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

Pre-requisite:
✅ JDK 17 (host)
✅ Jenkins LTS
✅ Git(Credentials Binding and branch to execute)
✅ Docker
✅ Docker Pipeline Plugin(agent { docker { ... } })
✅ Git Plugin
✅ GitHub credentials



Host: Jenkins, Git, Docker, plugins, credentials.
Container: Node.js, Playwright, browsers, project dependencies, and any test-execution tools (Allure CLI, Java runtime)

Next step is 
✅ Custom Playwright-Allure Docker image
The "mcr.microsoft.com/playwright:v1.60.0-jammy" image already contains:
Node.js, npm, Playwright, Browsers and it's dependencies.
Addtional intallation required on top: Install openJDK + allure-report

