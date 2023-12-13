FROM sgrio/java:jdk_8_centos

# Set environment variable for Maven version
ENV MVN_VERSION 3.6.3

# Install packages
# Install Maven
RUN echo "sslverify=0" >> /etc/yum.conf
RUN yum update -y
RUN yum reinstall -y ca-certificates
RUN yum install -y curl tar gzip git && \
  curl -fsSL http://archive.apache.org/dist/maven/maven-3/$MVN_VERSION/binaries/apache-maven-$MVN_VERSION-bin.tar.gz | tar xzf - -C /usr/share && \
  mv /usr/share/apache-maven-$MVN_VERSION /usr/share/maven && \
  ln -s /usr/share/maven/bin/mvn /usr/bin/mvn && \
  yum clean all && \
  rm -rf /var/cache/yum
ENV MAVEN_HOME /usr/share/maven
CMD ["mvn"]
