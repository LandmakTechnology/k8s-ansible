
#  **<span style="color:green">Mithun Technologies, Marathahalli ,Bengaluru.</span>**
### **<span style="color:green">Contacts: +91-9980923226, +91-8296242028<br> WebSite : <http://mithuntechnologies.co.in/></span>**
### **Email: devopstrainingblr@gmail.com, devopstrainingblr@outlook.com**


## **Agenda: Infrastructure Automation Using Terraform And K8's Cluster Configuration Using Ansible With Dynamic Inventory.**
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
$ sudo useradd ansible
$ echo "ansible  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ansible
$ sudo su ansible
```
### Install Terraform

``` sh
$ sudo su ansible
$ sudo yum install wget unzip -y
$ wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip
$ sudo unzip terraform_0.12.26_linux_amd64.zip -d /usr/local/bin/
# Export terraform binary path temporally
$ export PATH=$PATH:/usr/local/bin
# Add path permanently for current user.By Exporting path in .bashrc file at end of file.
$ vi .bashrc
   export PATH="$PATH:/usr/local/bin"
# Source .bashrc to reflect for current session
$ source ~/.bashrc   
```

### Ansible Installation
``` sh
$ sudo su ansible
$ sudo yum install python3 -y
$ sudo alternatives --set python /usr/bin/python3
$ sudo yum -y install python3-pip -y
$ pip3 install ansible --user
$ pip3 install boto3 --user
```

#### Clone terraform and ansible scripts
``` sh
$ git clone https://github.com/MithunTechnologiesDevOps/Kuberentes_Cluster_Terraform_Ansible.git
$ cd Kuberentes_Cluster_Terraform_Ansible
```
###### <span style="color:orange"> Update Your Key Name in variables.tf file before executing terraform script </span>
## Infrastructure As A Code
#### Create Infrastructure(VPC,Subnets,Route Tables,EC2 Instnaces ..etc) As A Code Using Terraform Scripts
``` sh
# Initialise to install plugins
$ terraform init terafrom_scripts/
# Validate teffaform scripts
$ terraform validate terafrom_scripts/
# Plan terraform scripts which will list resouce which will be created
$ terraform plan terafrom_scripts/
# Apply to create resources
$ terraform apply --auto-approve terafrom_scripts/
```

## Configuration Management

#### Check If DynamicInventory Script works.
```sh
$ chmod +x DynamicInventory.py
#Add default Region so that DynamicInventory will fetch host details from that Region.
# temporally
$ export AWS_DEFAULT_REGION=ap-south-1
# Or Permanently
#Create config file in current user .aws folder And below content.
$ mkdir ~/.aws
$ vi ~/.aws/config
[default]
region=ap-south-1

$ ./DynamicInventory.py --list
```
#### Kubernetes Cluster Setup Using Ansible (Configuration Management) With DynamicInventory.
- ###### <span style="color:green">Create a pem file and copy aws private key(pem) file content which you used in terraform.
</span>

```sh
$ vi DevOps.pem
$ chmod 400 DevOps.pem
```
- ###### <span style="color:orange">Replace \<Pemfile> with your pemfile path in server
</span>

```sh
$ ansible-playbook -i DynamicInventory.py site.yml -u ubuntu --private-key=<PemFilePath>  --ssh-common-args='-o StrictHostKeyChecking=no'
```
##  Destroy Infrastructure  
```sh
$ terraform destroy --auto-approve terafrom_scripts/
```
