############################################################
# Dockerfile to build a machine agent image to run on kubernetes with uniquehostid set as k8 node name
# Based on rajatparida86/appdynmachineagent
# Machine agent location on parent image -- /appdynamics-machine
# Image name -- rajatparida86/kubernetes-appdynmachineagent
############################################################
#Base image
FROM rajatparida86/appdynmachineagent

#Author of the file
MAINTAINER rajatparida86@gmail.com

# RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Make the repository as working dir
WORKDIR /appdynamics-machine

# Upload the machine agent start script to the image
ADD startmachineagent.sh .

# Add appropriate permission to the script
RUN chmod +x startmachineagent.sh


ENV APPDYNAMICS_CONTROLLER_HOST_NAME=172.199.0.30

ENV APPDYNAMICS_CONTROLLER_PORT=8090

ENV APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY=48a111af-14c8-470e-93b1-9c7044aa7e40

# Start the machine agent
CMD ["./startmachineagent.sh"]
