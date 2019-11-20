# Use the newest emacs version from silex as base
FROM silex/emacs:master-dev
COPY ["./.emacs.el", "Cask", "/root/"]
RUN cd /root; pwd; ls -la; cask install
