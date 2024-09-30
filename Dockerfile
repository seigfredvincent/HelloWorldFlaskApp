# Use the official Python image from Docker Hub
#FROM python:3.9-slim
FROM ubuntu

RUN apt update
RUN apt install python3-pip -y
RUN pip3 install Flask


# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
#COPY . /app
COPY . .
# Install the required Python packages
#RUN pip install Flask

# Make port 5000 available to the world outside this container
#EXPOSE 5000

# Define environment variable
#ENV FLASK_APP=app.py

# Run the Flask app
#CMD ["flask", "run", "--host=0.0.0.0"]
CMD [ "python3", "-m", "flask", "run", "--host=0.0.0.0" ]
