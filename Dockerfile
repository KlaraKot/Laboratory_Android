FROM ubuntu:18.04

#set the local
ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone 

RUN apt update && apt install -y build-essential zip unzip curl

#java 11
RUN apt-get update && apt-get install -y openjdk-11-jre


#Gradle

RUN cd /usr/local && \
    curl -L https://services.gradle.org/distributions/gradle-7.2-bin.zip -o gradle-7.2-bin.zip && \
    unzip gradle-7.2-bin.zip && \
    rm gradle-7.2-bin.zip


# Export some environment variables

ENV GRADLE_HOME=/usr/local/gradle-7.2
ENV PATH=$PATH:$GRADLE_HOME/bin JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

#Kotlin
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN curl -s https://get.sdkman.io | bash
RUN chmod a+x "$HOME/.sdkman/bin/sdkman-init.sh"
RUN source "$HOME/.sdkman/bin/sdkman-init.sh" && sdk install kotlin

CMD ["/bin/bash -c"]