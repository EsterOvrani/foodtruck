# TASK_2 ------------------------------------------------------------------------------------------------------------------------- 
# Stage 1: Build Node.js dependencies using Node Alpine
 FROM node:alpine3.11 AS node-build

 # Set working directory for the Node.js build
 WORKDIR /app
 
 # Copy the application source code
 COPY ./flask-app/ /app/
 
 # Install Node.js dependencies using npm
 RUN npm install 
 
 # Build the Node.js application
 RUN npm run build
 
 # Stage 2: Build Python dependencies using Python 2.7 Alpine
 FROM python:2.7-alpine3.11 AS python-build
 
 # Set working directory for Python
 WORKDIR /app
 
 # Copy the necessary files from the Node build stage
 COPY --from=node-build /app /app/
 
 # Copy the application source code to the container
 COPY ./flask-app/ /app/
 #COPY ./utils/ /app/
 
 # Install Python dependencies using pip
 RUN pip install --no-cache-dir -r /app/requirements.txt
 
 # Set the entrypoint to run the application
 ENTRYPOINT ["python", "/app/app.py"]
 
 
# TASK_1 ------------------------------------------------------------------------------------------------------------------------- 
# # Start with an empty Alpine image
# FROM alpine:3.11

# # Install dependencies (python2, pip, npm, and others as needed)
# RUN apk update && apk add --no-cache \
#     python2 \
#     py2-pip \
#     nodejs \
#     npm \
#     bash

# # Set working directory
# WORKDIR /app

# # Copy the application source code to the container
# COPY ./flask-app/ /app/

# # Install Python dependencies using pip
# RUN pip install --no-cache-dir -r /app/requirements.txt

# # Install Node.js dependencies using npm
# RUN npm install 

# # Build the Node.js application
# RUN npm run build 

# # Set the entrypoint to run the application
# ENTRYPOINT ["python", "/app/app.py"]
