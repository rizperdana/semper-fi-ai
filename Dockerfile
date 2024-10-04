FROM python:3.10.2-slim-bullseye

# Set environment variables
ENV PIP_DISABLE_PIP_VERSION_CHECK 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /code

# Copy and install requirements
COPY ./requirements.txt .

# Update and install necessary packages
RUN apt-get update -y && \
    apt-get install -y netcat curl && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# Copy entrypoint script and make it executable
COPY ./entrypoint.sh .
RUN chmod +x /code/entrypoint.sh

# Copy the application code
COPY . .

# Set the entrypoint
ENTRYPOINT ["/code/entrypoint.sh"]
