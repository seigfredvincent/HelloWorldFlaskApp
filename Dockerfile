# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install Flask and pytest
RUN pip install Flask pytest  && \
apt-get update && apt-get install -y curl unzip && \
curl -L -o dependency-check.zip https://github.com/jeremylong/DependencyCheck/releases/download/v8.2.1/dependency-check-8.2.1-release.zip && \
unzip dependency-check.zip -d /opt && \
rm dependency-check.zip && \
chmod +x /opt/dependency-check/bin/dependency-check.sh

# Set PYTHONPATH to ensure the app can be found
ENV PYTHONPATH=/app

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variable
ENV FLASK_ENV=development

# Run app.py when the container launches
CMD ["python", "app.py"]
