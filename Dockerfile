# Use the newest emacs version from silex as base
FROM silex/emacs
COPY ["emacs.el", "/root/.emacs.el"]
COPY ["startup.sh", "/root"]
COPY ["Cask", "/root/.emacs.d/Cask"]
ENV git.email="mulenatic@gmail.com" \
  git.user="Thomas Kaczmarek" \
  PATH="/root/.cask/bin:$PATH"
RUN apt-get update; apt-get install -y python git; rm -rf /var/lib/apt/lists/*; \
  git config --global user.email $git.user; git config --global user.name $git.user; \
  curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python; \
  cd /root/.emacs.d; cask install
ENTRYPOINT ["/root/startup.sh"]
#ENTRYPOINT ["emacs"]
#CMD ["/data"]
