FROM ubuntu:16.04
ENV tmpdir /opt
RUN /usr/bin/apt-get update && /usr/bin/apt-get install -y libc-bin wget openssl curl sudo python-ctypes sysv-rc net-tools rsyslog cron vim dmidecode apt-transport-https && rm -rf /var/lib/apt/lists/*
COPY rsyslogconf.py setup.sh main.sh $tmpdir/
COPY security-config.conf /etc/rsyslog.d/
WORKDIR ${tmpdir}
RUN chmod 775 $tmpdir/*.sh; sync; $tmpdir/setup.sh
EXPOSE 514/TCP
EXPOSE 514/UDP 
CMD [ "/opt/main.sh" ]
