FROM ubuntu:18.04
ENV tmpdir /opt
RUN /usr/bin/apt-get update && /usr/bin/apt-get install -y libc-bin wget openssl curl sudo python-ctypes net-tools rsyslog rsyslog-gnutls cron vim dmidecode apt-transport-https && rm -rf /var/lib/apt/lists/*
COPY setup.sh main.sh $tmpdir/
COPY rsyslog.conf /etc/rsyslog.d/rsyslog.conf.template
COPY security-config.conf /etc/rsyslog.d/
WORKDIR ${tmpdir}
RUN chmod 775 $tmpdir/*.sh; sync; $tmpdir/setup.sh
EXPOSE 514/TCP
EXPOSE 514/UDP 
EXPOSE 6514/TCP
EXPOSE 6514/UDP
CMD [ "/opt/main.sh" ]
