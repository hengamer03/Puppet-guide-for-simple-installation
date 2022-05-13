# Puppet Guide for simple installation

### Welcome to my simple guide on how to set up a very easy puppet enviorment using vagrant
### Provided files here are used to set up your Vagrant enviorment using HyperV and the files you will need to create a simple Module in the production evironment.


# Guide

### Vagrant setup

#### 1. whatever platform youre on make sure you download Vagrant, i Used windows for this so i downloaded from vagrant's official website at https://www.vagrantup.com/

#### 2. if you use windows you can choose between many virtualization platforms but i chose the built in HyperV, This however requires you have the pro versions of windows. to activate go to : Control Panel / programs / activate or deactivate a windows-function / activate all HyperV settings and then reboot your pc

#### 3. when this is done open a powershell session, create a Vagrant directory on your pc where you place all vagrant files. in here create a directory for your puppet test environment. Create a "Vagrantfile" and copy paste my Vagrantfile into it. What this does is it creates your Puppetserver called master with the hostname puppet.example.com and it uses Rhel 8 as its OS, and has 4GB of ram, it also creates a second VM called Client1 with hostname puppetagent01.example.com and this server only has 2GB of ram since it doesnt require alot of resources.

#### 4. when this is done save the Vagrantfile and simply type "vagrant up" and it creates both VM's in just a few minutes. when the setup is done simply type in "vagrant ssh master" this creates a ssh session into your master VM, from here if you use Rhel8 make sure you subscribe the VM's, if you dont you wont get the needed repos.  do this on your puppetagent as well. I recomend having two windows with both your puppetserver and puppetagent01 on. 

### Puppet setup

### now you have the enviorment for testing set up, lets set up puppet. from now i will refer to the "puppetserver" node as master and the "puppetagent01" node as client.

#### 1. on your master, enable the puppet 7 repo by typing in "sudo rpm -Uvh https://yum.puppet.com/puppet7-release-el-8.noarch.rpm" to check if it installed type "yum repolist" and it should pup up (note if you use any other VM OS you will need to find another repo since this only works for RHEL8) 

#### 2. Download puppetserver with "yum install -y puppetserver" this downlaods the puppetserver and its dependencies

#### 3. start the puppetserver with " systemctl start puppetserver"

#### 4. now you tell the master that this is the Main Puppetserver by typing in "puppet config set server puppet.example.com --section main" Now any puppet agent on the same network will recognize this as the puppetserver. 

#### 5. for ease in this test i disabled the firewalld service on both master and client with "systemctl stop firewald.service" 

#### 6. on the client enable the same repo as on the master and download puppet-agent with "yum install -y puppet-agent" this should have no dependencies. 

#### 7. make sure you can ping the master. and then in your /etc/hosts file add the Master Ip address and set it to use the name "puppet" 

#### 8. now using a script that the puppet-agent downloaded type in "source /etc/profile.d/puppet-agent.sh" 

#### 9. now type in "puppet ssl bootstrap" to create a ssl certificate request to the master, on the master you have to sign it using "puppetserver ca sign --certname puppetagent01.example.com" and now the client should be connected up to the master, test this by typing in "puppet agent -t" in just a few seconds it should say "applied catalog" this means it manage to pull any configs onto the client and the connection is done

### Your first module

#### now you can write code on the puppetserver and pull it down to any clients you have connected and the subsequent code will do changes on the clients. this will help you get an idea on how you write a simple module to pull down to the client

#### 1. on the master go to the /etc/puppetlabs/code/environments/production/modules/

#### 2. create new directories here using "mkdir -p cowsay/manifests" this creates the module cowsay and in its manifest create a file called "init.pp"

#### 3. go into any text editory you prefer and type in what my attached init.pp file says. What does the code actually do? first it downloads the package "gem" using yum, then the second part downloads cowsay using gem. 

#### 4. save this file and go to the production directory below modules. from here create a file in the manifests directory called "site.pp" copy my attached site.pp text into here, this file tells puppet that the client node must have the cowsay module. 

#### 5. save that file and on the client run the command "puppet agent -t" once again and it should say it staged the Cowsay package. reboot the client, and log back on and then type in 'cowsay "congratulatins" ' now a simple art of a cow should appear and the text bouble should say what you typed in


### congrats on making it, this is a very simple introdution to puppet. puppet is very powerful and can be used in many usecases. 
