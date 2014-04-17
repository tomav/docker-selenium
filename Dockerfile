FROM ubuntu:12.04
MAINTAINER Thomas VIAL

# Update and install packages
RUN apt-get update
RUN apt-get -y install vim curl screen firefox zsh git xvfb openjdk-7-jre

# Create "selenium" user with password crypted "selenium"
RUN useradd -d /home/selenium -m -s /bin/zsh selenium
RUN echo "selenium:selenium" | chpasswd

# Add "selenium" to "sudoers"
RUN echo "selenium        ALL=(ALL:ALL) ALL" >> /etc/sudoers

USER selenium
WORKDIR /home/selenium
ENV HOME /home/selenium
ENV PATH $PATH:/home/selenium

# Clone oh-my-zsh
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git /home/selenium/.oh-my-zsh/

# Create a new zsh configuration from the provided template
ADD .zshrc /home/selenium/.zshrc

# Get selenium-server
RUN mkdir selenium-server
RUN curl -o selenium-server/selenium-server-standalone-2.41.0.jar http://selenium-release.storage.googleapis.com/2.41/selenium-server-standalone-2.41.0.jar
