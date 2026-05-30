FROM mcr.microsoft.com/playwright:v1.60.0-jammy

# Install OpenJDK 17 (required for Allure report generation)
RUN apt-get update && apt-get install -y \
    openjdk-17-jre-headless \
    && rm -rf /var/lib/apt/lists/*

# Install Allure CLI for generating HTML reports
RUN npm install -g allure-commandline

WORKDIR /app

ENV BASE_URL=https://playwright.dev

# Copy dependency files for layer caching
COPY package.json package-lock.json ./

# Install Node dependencies
RUN npm ci

# Copy application code
COPY . .

# Healthcheck to verify Playwright and Allure are available
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD npx playwright --version && allure --version || exit 1

CMD ["npx", "playwright", "test", "example.spec,ts", "--reporter=html", "--output=playwright-report"]
