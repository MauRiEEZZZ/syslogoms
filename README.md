# Syslog to Azure Sentinel
A docker image containing rsyslog and omsagent that will be used to send logs to Log Analytics (Azure Sentinel)

## Why this Container Image?
To connect your external appliance to Azure Sentinel, an agent must be deployed on a dedicated machine (VM or on premises) to support the communication between the appliance and Azure Sentinel. You can deploy the agent automatically or manually. Automatic deployment is only available if your dedicated machine is a new VM you are creating in Azure.

![Image of On prem syslog to azure hosted agent connection](https://docs.microsoft.com/en-us/azure/sentinel/media/connect-cef/cef-syslog-azure.png)

Alternatively, you can deploy the agent manually on an existing Azure VM, on a VM in another cloud, or on an on-premises machine.

![Image of On prem syslog to On prem hosted agent connection](https://docs.microsoft.com/en-us/azure/sentinel/media/connect-cef/cef-syslog-onprem.png)

This container allows you to easily deploy the agent manually with a few (docker) commands.

## How to use this container on a host

### Prepare all necessary files and build the container
```
$> git clone https://github.com/zolderio/syslogoms.git
$> cd syslogoms
$> sudo docker build -t syslogoms .
```

### Start the OMS container with TLS enabled:
First generate certificates using the following instructions:
https://www.thegeekdiary.com/how-to-configure-rsyslog-server-to-accept-logs-via-ssl-tls/

Copy the generated ca.pem, cert.pem en key.pem to your current directory and run the following command (please note: make sure that the permissions on the pem files are sufficient for the rsyslog process to read them):
```
$> sudo docker run -d -e WSID="your workspace id" -e KEY="your key" -e TLS="true" -p 514:514/tcp -p 514:514/udp -p 6514:6514/tcp -v $(pwd)/ca.pem:/etc/rsyslog.d/ca.pem -v $(pwd)/cert.pem:/etc/rsyslog.d/cert.pem -v $(pwd)/key.pem:/etc/rsyslog.d/key.pem --restart=always syslogoms
```

### Start the OMS container without TLS enabled:
```
$> sudo docker run -d -e WSID="your workspace id" -e KEY="your key" -e TLS="false" -p 514:514/tcp -p 514:514/udp --restart=always syslogoms
```
