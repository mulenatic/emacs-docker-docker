# Use the newest emacs version from silex as base
FROM mulenatic/emacs-docker
RUN apt-get update && \
	apt-get -y install apt-transport-https \
	ca-certificates \
	curl \
	gnupg2 \
	software-properties-common && \
	curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
	$(lsb_release -cs) \
	stable" && \
	apt-get update && \
	apt-get -y install docker-ce; \
	rm -rf /var/lib/apt/lists/*;
RUN echo '(depends-on "dockerfile-mode")' >> /root/.emacs.d/Cask; \
	cd /root/.emacs.d/; cask install; \
	sed -i 's/#TestAddons/echo "Testing if docker.sock file is present";\nif [ -f \/var\/run\/docker.sock ]; \nthen \necho "The hosts docker.sock file has not been mounted into the container. Please start the container with \"-v \/var\/run\/docker.sock:\/var\/run\/docker.sock\".";\n exit 1;\nfi;\n#TestAddons/g' /root/startup.sh
ENTRYPOINT ["/root/startup.sh"]
#ENTRYPOINT ["emacs"]
#CMD ["/data"]
