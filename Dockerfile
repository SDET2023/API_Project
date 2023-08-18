FROM openjdk:11
RUN echo "petpartners automation"
RUN apt-get update && apt-get install -y unzip
WORKDIR /gradle
RUN curl -L https://services.gradle.org/distributions/gradle-6.5.1-bin.zip -o gradle-6.5.1-bin.zip
RUN unzip gradle-6.5.1-bin.zip
ENV GRADLE_HOME=/gradle/gradle-6.5.1
ENV PATH=$PATH:$GRADLE_HOME/bin
RUN echo "petpartners"
RUN mkdir /tmp/petpartners-automation
COPY ./petpartners-api /tmp/petpartners-automation/petpartners-api
COPY ./petpartners-common /tmp/petpartners-automation/petpartners-common
COPY ./petpartners-ui-akc /tmp/petpartners-automation/petpartners-ui-akc
COPY ./petpartners-ui-orca /tmp/petpartners-automation/petpartners-ui-orca
COPY ./petpartners-ui-ppi /tmp/petpartners-automation/petpartners-ui-ppi
COPY ./petpartners-ui-paw-some /tmp/petpartners-automation/petpartners-ui-paw-some
COPY ./settings.gradle /tmp/petpartners-automation/settings.gradle
COPY ./launch.sh /tmp/launch.sh
RUN chmod 777 /tmp/launch.sh
ENTRYPOINT ["/bin/sh","/tmp/launch.sh"]