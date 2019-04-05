FROM nbulai/ruby-chromedriver:latest

ENV DEBIAN_FRONTEND noninteractive

# Install Java JDK8
RUN apt-get update && \
	apt-get install -y openjdk-8-jdk && \
	apt-get install -y ant && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	rm -rf /var/cache/oracle-jdk8-installer;
	
# Fix certificate issues Java
RUN apt-get update && \
	apt-get install -y ca-certificates-java && \
	apt-get clean && \
	update-ca-certificates -f && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;

# Setup JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

# Install Node e Npm
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update && apt-get install -y nodejs

# Install Alure
RUN npm install -g allure-commandline

# Creating folders and copying project
RUN mkdir /tests
WORKDIR /tests
ADD Gemfile /tests/Gemfile
ADD Gemfile.lock /tests/Gemfile.lock
RUN bundle install
ADD . /tests