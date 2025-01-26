# Start with an empty Alpine image
FROM alpine:3.11

# Install dependencies (python2, pip, npm, and others as needed)
RUN apk update && apk add --no-cache \
    python2 \
    py2-pip \
    nodejs \
    npm \
    bash

# Set working directory
WORKDIR /app

# Copy the application source code to the container
COPY ./flask-app/ /app/

# Install Python dependencies using pip
RUN pip install --no-cache-dir -r /app/requirements.txt

# Install Node.js dependencies using npm
RUN npm install 

# Build the Node.js application
RUN npm run build 

# Set the entrypoint to run the application
ENTRYPOINT ["python", "/app/app.py"]
