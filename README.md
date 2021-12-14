
#  **<span style="color:green">Landmark Technology.</span>**
### **<span style="color:green">Contacts: +1437215 24 83   +1 437 215 2483 <br> WebSite : <http://mylandmarktech.com/></span>**
### **Email: mylandmarktech@gmail.com         mylandmarktech@gmail.com**


## **Agenda: Infrastructure Automation Using Terraform and Ansible With Dynamic Inventory to configure a Kubernetes Cluster**
## Terraform, Ansible Installation And Setup In AWS EC2 Redhat Instnace.
##### Prerequisite
+ AWS Acccount.
+ Create Redhat EC2 Instnace.
+ Create IAM Role With Required Polocies.
   + VPCFullAccess
   + EC2FullAcces
   + S3FullAccess  ..etc
+ Attach IAM Role to EC2 Instance.

### Create User To Install Ansible & Terraform
``` sh
 sudo useradd ansible
 echo "ansible  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ansible
 sudo su ansible
```
### Enable password authentication and assign password to ansible user
``` sh
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo service sshd restart
sudo passwd ansible
### Install Terraform
```
##### Install terraform
``` sh
 sudo su - ansible
 sudo yum install wget unzip -y
 wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip
 sudo unzip terraform_0.12.26_linux_amd64.zip -d /usr/local/bin/
# Export terraform binary path temporally
 export PATH=$PATH:/usr/local/bin
# Add path permanently for current user.By Exporting path in .bashrc file at end of file.
$ vi .bashrc
   export PATH="$PATH:/usr/local/bin"
# Source .bashrc to reflect for current session
 source ~/.bashrc   

# terraform installation in ubuntu 
$ curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

 sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

 sudo apt-get update && sudo apt-get install terraform
```

### Ansible Installation
``` sh
 sudo su ansible
 sudo yum install python3 -y
 sudo alternatives --set python /usr/bin/python3
 sudo yum -y install python3-pip -y
 pip3 install ansible --user
 pip3 install boto3 --user
```

#### Clone terraform and ansible scripts
``` sh
 git clone https://github.com/LandmakTechnology/k8s-ansible.git
 cd Kuberentes_Cluster_Terraform_Ansible
```
###### <span style="color:orange"> Update Your Key Name in variables.tf file before executing terraform script </span>
## Infrastructure As A Code
#### Create Infrastructure(VPC,Subnets,Route Tables,EC2 Instnaces ..etc) As A Code Using Terraform Scripts
``` sh
# Initialise to install plugins
 terraform init terafrom_scripts/
# Validate teffaform scripts$ terraform validate terafrom_scripts/
# Plan terraform scripts which will list resouce which will be created
 terraform plan terafrom_scripts/
# Apply to create resources
 terraform apply --auto-approve terafrom_scripts/
```

## Configuration Management

#### Check If DynamicInventory Script works.
```sh
 chmod +x DynamicInventory.py
#Add default Region so that DynamicInventory will fetch host details from that Region.
# temporally
 export AWS_DEFAULT_REGION=us-west-2
# Or Permanently
#Create config file in current user .aws folder And below content.
 mkdir ~/.aws
 vi ~/.aws/config
[default]
region=us-west-2

$ ./DynamicInventory.py --list
```
#### Kubernetes Cluster Setup Using Ansible (Configuration Management) With DynamicInventory.
- ###### <span style="color:green">Create a pem file and copy aws private key(pem) file content which you used in terraform.
</span>

```sh
 vi key.pem
 chmod 400 key.pem
```
- ###### <span style="color:orange">Replace \<Pemfile> with your pemfile path in server
</span>

```sh
 ansible-playbook -i DynamicInventory.py site.yml -u ubuntu --private-key=<PemFilePath>  --ssh-common-args='-o StrictHostKeyChecking=no'
```
##  Destroy Infrastructure  
```sh
 terraform destroy --auto-approve terafrom_scripts/
```
