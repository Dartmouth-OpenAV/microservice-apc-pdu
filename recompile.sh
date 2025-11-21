# Linux dev script for testing and development of the microservice.
# This removes any old containers and rebuilds a new one with your changes.
# Run when you update the code and need to deploy a new test container.

# Find container (running or stopped) for this image
container=$(sudo docker ps -aqf "ancestor=microservice-apc-pdu")

# Stop and remove if found
if [ -n "$container" ]; then
  sudo docker stop "$container" >/dev/null 2>&1
  sudo docker rm "$container"
fi

# Rebuild and run
sudo docker build -t microservice-apc-pdu .
sudo docker run -d -p 80:80 microservice-apc-pdu
