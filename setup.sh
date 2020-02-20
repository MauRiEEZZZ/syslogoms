TMPDIR="/opt"
cd $TMPDIR

wget -q https://github.com/microsoft/OMS-Agent-for-Linux/releases/download/OMSAgent_v1.12.15-0/omsagent-1.12.15-0.universal.x64.sh

#create file to disable omi service startup script
touch /etc/.omi_disable_service_control

chmod 775 $TMPDIR/*.sh

#Extract omsbundle
$TMPDIR/omsagent-*.universal.x64.sh --extract
mv $TMPDIR/omsbundle* $TMPDIR/omsbundle
#Install omi
/usr/bin/dpkg -i $TMPDIR/omsbundle/100/omi*.deb

#Install scx
/usr/bin/dpkg -i $TMPDIR/omsbundle/100/scx*.deb

#Install omsagent and omsconfig
/usr/bin/dpkg -i $TMPDIR/omsbundle/100/omsagent*.deb
/usr/bin/dpkg -i $TMPDIR/omsbundle/100/omsconfig*.deb


# Configure for Configuration for collection of security solution logs 
python rsyslogconf.py
wget https://raw.githubusercontent.com/microsoft/OMS-Agent-for-Linux/master/installer/conf/omsagent.d/security_events.conf -O /opt/security_events.conf

#sed -i 's/port 25226/port 25226/g' input.txt

rm -rf $TMPDIR/omsbundle
rm -f $TMPDIR/omsagent*.sh

