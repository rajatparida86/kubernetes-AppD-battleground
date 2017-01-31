############################################################
# Dockerfile to build a sample python to redis talker
# Monitored with Appdynamics python agent
# Based on rajatparida86/appdynpythonmonitor
# Image name -- rajatparida86/sample-redis-talker
############################################################
#Base image
FROM rajatparida86/appdynpythonmonitor

#Author of the file
MAINTAINER rajatparida86@gmail.com

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

EXPOSE 5000
COPY app.py /application
COPY build.sh /application
COPY requirements.txt /application
COPY appdynamics.cfg /application
COPY startredistalker.sh /application

WORKDIR /application

# Add appropriate permission to the scripts
RUN chmod +x startredistalker.sh

#RUN source venv/bin/activate
#RUN pip install flask
#RUN pip install redis
#CMD [ "python", "app.py" ]

CMD ["./startredistalker.sh"]
