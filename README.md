# loganalytics-syslog
a docker image containing omsagent that will be used to send logs to Log Analytics, and rsyslog configured to send Common Event Formatted messages to CommonSecurityLogs.

## Why this Container Image?
To connect your external appliance to Azure Sentinel, an agent must be deployed on a dedicated machine (VM or on premises) to support the communication between the appliance and Azure Sentinel. You can deploy the agent automatically or manually. Automatic deployment is only available if your dedicated machine is a new VM you are creating in Azure....
![Image of On prem syslog to azure hosted agent connection](https://docs.microsoft.com/en-us/azure/sentinel/media/connect-cef/cef-syslog-azure.png)
Alternatively, you can deploy the agent manually on an existing Azure VM, on a VM in another cloud, or on an on-premises machine.
![Image of On prem syslog to On prem hosted agent connection](https://docs.microsoft.com/en-us/azure/sentinel/media/connect-cef/cef-syslog-onprem.png)

With the convenience of running a simple container image you can deploy the 'syslog agent' within minutes.

### How to use on a container host

- Start the OMS container:
```
$>sudo docker run -d -e WSID="your workspace id" -e KEY="your key" -p 514:514/tcp -p 514:514/udp --restart=always meauris/syslogoms
```

## What now?
Once you're set up, we'd like you to try the following scenarios and play around with the system.
