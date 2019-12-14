# Use the newest emacs version from silex as base
FROM mulenatic/emacs-docker:v2.1.1
RUN sudo apt-get update; \
	sudo apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common; \
	sudo curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; \
	sudo apt-key add /tmp/dkey; \
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"; \
	sudo apt-get update; \
	sudo apt-get -y install docker-ce; \
	sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;
USER docker
RUN echo '(depends-on "dockerfile-mode")\n(depends-on "docker")' >> /home/docker/.emacs.d/Cask; \
	cd /home/docker/.emacs.d/; cask install; \
	sed -i 's/#TestAddons/echo "Testing if docker.sock file is present";\nif [ -f \/var\/run\/docker.sock ]; \nthen \necho "The hosts docker.sock file has not been mounted into the container. Please start the container with \"-v \/var\/run\/docker.sock:\/var\/run\/docker.sock\".";\n exit 1;\nfi;\n#TestAddons/g' /home/docker/startup.sh; \
	sed -i 's/#scriptAddons/sudo chgrp docker \/var\/run\/docker.sock;\n\n#scriptAddons/g' /home/docker/startup.sh; 

