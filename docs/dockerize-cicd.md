# Dockerizing a Python Flask Application and Setting Up CI/CD Pipeline

## Introduction
This guide will walk you through the process of **dockerizing** a simple **Python Flask** application and setting up an automated **CI/CD pipeline** using **GitHub Actions**.

## Steps to Dockerize the Application

1. **Create the Python Flask Application**:
   The `app.py` file defines a simple web server that responds with a "Hello World" message.

2. **Write the Dockerfile**:
   The `Dockerfile` defines the steps to containerize the Python Flask application.

3. **Build the Docker Image**:
   Run the following command to build the Docker image:

   ```bash
   docker build -t my-python-app .

4. Run the Docker Container: Run the container with:

    ```bash
    docker run -p 5000:5000 my-python-app
    ```

5. Test the Application: Open a browser and go to `http://localhost:5000` to see the application.

## Setting Up CI/CD Pipeline with GitHub Actions

1. **Create the GitHub Actions Workflow**: Add the .github/workflows/ci-cd-pipeline.yml file to define the build and deployment steps.

2. **Configure Secrets**: Add your DOCKER_USERNAME and DOCKER_PASSWORD to your GitHub repository secrets.

3. **Push Changes**: Push your changes to GitHub, which will trigger the CI/CD pipeline.

4. **Monitor the Build**: Go to the Actions tab on your GitHub repository to monitor the build process.