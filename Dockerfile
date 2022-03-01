# Use an official Python runtime as a parent image
FROM python:3.8
# Set the working directory to /app
WORKDIR /app
# Copy the current directory contents into the container at /app
ADD . /app
# remove the file
RUN rm -rf variable.tf
# Install any needed packages specified in requirements.txt
# ["__BUILD_NUMBER", "README.md", "gulpfile", "another_file", "./"]
RUN pip install --trusted-host pypi.python.org -r requirements.txt
# Make port 5000 available to the world outside this container
EXPOSE 5000
# Define environment variable
ENV NAME perscholas
# Run app.py when the container launches
CMD ["python", "app.py"]
