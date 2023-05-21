# Step 2: Install Docker and Docker Compose
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker ${USER}
sudo systemctl enable docker
sudo systemctl start docker
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Step 3: Create Dockerfile and Docker Compose for Jenkins
mkdir ~/docker_deploy
cd ~/docker_deploy
cat <<EOF > Dockerfile
FROM jenkins/jenkins:lts
USER root
RUN apt-get update && apt-get -y install apt-transport-https \
       ca-certificates curl gnupg2 \
       software-properties-common
RUN curl -fsSL https://get.docker.com -o get-docker.sh
RUN sh get-docker.sh
RUN usermod -aG docker jenkins
USER jenkins
EOF
cat <<EOF > docker-compose.yml
version: '3.8'
services:
  jenkins:
    build: .
    ports:
      - '8090:8080'
EOF
sudo docker-compose up -d
