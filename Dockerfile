FROM jenkinsci/jenkins:latest
RUN /usr/local/bin/install-plugins.sh workflow-aggregator job-dsl git build-flow-plugin docker-build-publish amazon-ecr amazon-ecs docker-workflow 
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

USER root
RUN apt-get -y update && apt-get install -y sudo jq curl python-setuptools && easy_install pip && pip install awscli
COPY ecs-deploy /usr/local/bin/ecs-deploy
RUN chmod a+x /usr/local/bin/ecs-deploy
ENTRYPOINT ["/usr/local/bin/ecs-deploy"]
