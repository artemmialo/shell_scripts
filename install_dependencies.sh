#!/bin/bash -e

#Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

#Install Terraform
sudo apt-get install wget unzip --yes
wget https://releases.hashicorp.com/terraform/0.12.13/terraform_0.12.13_linux_amd64.zip
unzip terraform_0.12.13_linux_amd64.zip
sudo mv terraform /usr/local/bin

#Install nodejs
sudo snap install node --classic --channel=13

#Register Microsoft key and feed
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

#Install the .NET 3.0 SDK
sudo add-apt-repository universe
sudo apt-get update --yes
sudo apt-get install apt-transport-https --yes
sudo apt-get update --yes
sudo apt-get install dotnet-sdk-3.0 --yes

#Add VM to Azure DevOps
sudo mkdir myagent && cd myagent
wget https://vstsagentpackage.azureedge.net/agent/2.160.0/vsts-agent-linux-x64-2.160.0.tar.gz
tar zxvf vsts-agent-linux-x64-2.160.0.tar.gz
sudo ./config.sh --url https://dev.azure.com/foodtruckinc/ --auth pat --token $1 --unattended --pool $2 --agent $3 --acceptTeeEula OB
sudo ./svc.sh install
sudo ./svc.sh start
