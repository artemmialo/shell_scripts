#!/bin/bash -e

#Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | bash

#Install Terraform
apt-get install wget unzip --yes
wget https://releases.hashicorp.com/terraform/0.12.13/terraform_0.12.13_linux_amd64.zip
unzip terraform_0.12.13_linux_amd64.zip
mv terraform /usr/local/bin

#Install nodejs
snap install node --classic --channel=13

#Register Microsoft key and feed
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb

#Install the .NET 3.0 SDK
add-apt-repository universe
apt-get update --yes
apt-get install apt-transport-https --yes
apt-get update --yes
apt-get install dotnet-sdk-3.0 --yes

#Add VM to Azure DevOps
mkdir myagent && cd myagent
wget https://vstsagentpackage.azureedge.net/agent/2.160.0/vsts-agent-linux-x64-2.160.0.tar.gz
tar zxvf vsts-agent-linux-x64-2.160.0.tar.gz
./config.sh --url https://dev.azure.com/foodtruckinc/ --auth pat --token $1 --unattended --pool $2 --agent $3 --acceptTeeEula OB
./svc.sh install
./svc.sh start
