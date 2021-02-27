FROM cliwrap/bionic:latest
MAINTAINER https://github.com/cliwrap/latex
RUN apt-get update \
  && apt-get -y install \
    texlive-latex-recommended \
    texlive-latex-extra \
  && apt-get clean autoclean -y \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt \
    /var/lib/dpkg/arch \
    /var/lib/dpkg/available \
    /var/lib/dpkg/cmethopt \
    /var/lib/dpkg/diversions \
    /var/lib/dpkg/diversions-old \
    /var/lib/dpkg/lock \
    /var/lib/dpkg/parts \
    /var/lib/dpkg/statoverride \
    /var/lib/dpkg/status-old \
    /var/lib/dpkg/triggers \
    /var/lib/cache \
    /var/lib/log
ENTRYPOINT ["/run-as-hostuid.sh"]
