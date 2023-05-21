
# Step 3: Create Dockerfile and Docker Compose for Jenkins
FROM jenkins/jenkins:lts
USER root
RUN apt-get update && apt-get -y install apt-transport-https \
       ca-certificates curl gnupg2 \
       software-properties-common
RUN curl -fsSL https://get.docker.com -o get-docker.sh
RUN sh get-docker.sh
RUN usermod -aG docker jenkins
USER jenkins
