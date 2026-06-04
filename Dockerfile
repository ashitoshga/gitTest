FROM mcr.microsoft.com/playwright:v1.60.0-jammy

# Install OpenJDK 17 (required for Allure report generation)
RUN apt-get update && apt-get install -y \
    openjdk-17-jre-headless \
    && rm -rf /var/lib/apt/lists/*

# Install Allure CLI for generating HTML reports
RUN npm install -g allure-commandline

WORKDIR /app

# Copy dependency files for layer caching
COPY package*json ./

RUN npm install 

# Install Node dependencies
RUN npm ci

# Copy application code
COPY . .