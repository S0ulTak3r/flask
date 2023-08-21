# Use an officssial Python runtime as a parent image
FROM python:3.10.12

# Set a directory for the app
WORKDIR /usr/src/app

# Install system-level dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev

# Copy all the files to the container
COPY . .

COPY ./Static/UnityBuild /usr/src/app/Static/UnityBuild

# Install dependencies
RUN pip install --no-cache-dir --default-timeout=1000 -r requirements.txt


# Tell the port number the container should expose
EXPOSE 5000

# Run the command
CMD ["python", "./app.py"]
