TMPDIR="/opt"
cd $TMPDIR

wget -q https://github.com/Microsoft/OMS-Agent-for-Linux/releases/download/OMSAgent_v1.6.0-42/omsagent-1.6.0-42.universal.x64.sh

#create file to disable omi service startup script
touch /etc/.omi_disable_service_control
#I wish to disable the cimprov let's see if this is enough
#wget https://github.com/Microsoft/Docker-Provider/releases/download/1.0.0-33/docker-cimprov-1.0.0-33.universal.x86_64.sh
chmod 775 $TMPDIR/*.sh

#Extract omsbundle
$TMPDIR/omsagent-*.universal.x64.sh --extract
mv $TMPDIR/omsbundle* $TMPDIR/omsbundle
#Install omi
/usr/bin/dpkg -i $TMPDIR/omsbundle/100/omi*.deb

#Install scx
/usr/bin/dpkg -i $TMPDIR/omsbundle/100/scx*.deb
$TMPDIR/omsbundle/bundles/scx-1.6.*-*.universal.x64.sh --install

#Install omsagent and omsconfig
/usr/bin/dpkg -i $TMPDIR/omsbundle/100/omsagent*.deb
/usr/bin/dpkg -i $TMPDIR/omsbundle/100/omsconfig*.deb


# Configure for Configuration for collection of security solution logs 
# https://github.com/microsoft/OMS-Agent-for-Linux/blob/master/docs/Security-Events-Preview-Configuration.md
python rsyslogconf.py
wget https://github.com/Microsoft/OMS-Agent-for-Linux/blob/master/installer/conf/omsagent.d/security_events.conf -O /opt/security_events.conf

rm -rf $TMPDIR/omsbundle
rm -f $TMPDIR/omsagent*.sh

