# Setting up Development Env
## Installation of Vagrant, Virtual box and Ruby
### vagrant commands
- `vagrant up` to launch the vm
- `vagrant destroy` to delete everything
- `vagrant reload` to reload any new instraction in our `Vagrantfile`
- `vagrant halt` to pause the virtual machine
- `vagrant status` 

#### More commands can be found by typing `vagrant` on gitbash terminal
```
 autocomplete    manages autocomplete installation on host
box             manages boxes: installation, removal, etc.
cloud           manages everything related to Vagrant Cloud
destroy         stops and deletes all traces of the vagrant machine
global-status   outputs status Vagrant environments for this user
halt            stops the vagrant machine
help            shows the help for a subcommand
init            initializes a new Vagrant environment by creating a Vagrantfile
login
package         packages a running vagrant environment into a box
plugin          manages plugins: install, uninstall, update, etc.
port            displays information about guest port mappings
powershell      connects to machine via powershell remoting
provision       provisions the vagrant machine
push            deploys code in this environment to a configured destination
rdp             connects to machine via RDP
reload          restarts vagrant machine, loads new Vagrantfile configuration
resume          resume a suspended vagrant machine
snapshot        manages snapshots: saving, restoring, etc.
ssh             connects to machine via SSH
ssh-config      outputs OpenSSH valid configuration to connect to the machine
status          outputs status of the vagrant machine
suspend         suspends the machine
up              starts and provisions the vagrant environment
upload          upload to machine via communicator
validate        validates the Vagrantfile
version         prints current and latest Vagrant version
winrm           executes commands on a machine via WinRM
winrm-config    outputs WinRM configuration to connect to the machine
```

- Let's `ssh` into our vm and launch nginx web-server
- use `apt-get` package manager in Linux 
- `apt-get` is used to install and uninstall any packages needed
- To use the command in `admin` we can use `sudo` before the command
- `sudo apt-get upgrade -y` 
- `sudo apt-get update -y`
- `ping www.bbc.co.uk`
- `sudo apt-get install name_of_the_package`
- To work in an `admin mode` at all times (not recommended) `sudo -su` and you'll land in admin mode
- We will install nginx in our guest machine/VM/ ubuntu 16.04
- Lanuch the default nginx page in host machine's browser
- To come out of your VM `exit`
- install nginx `sudo apt-get install nginx -y`
- Checking status of nginx `sudo systemctl status nginx` 
- or restart `systemctl restart nginx` or just start `systemctl start nginx`

## Installing plugin

- Step 1: Install the plugin `vagrant plugin install vagrant-hostsupdater`

- Step 2: `vagrant destroy`

- Step 3: Add this line of code into Vagrantfile `config.hostsupdater.aliases = ["development.local"]`

- Step 4: `vagrant up`

- Step 5: `vagrant ssh`

- Step 6: Repeat all of the updates and upgrade commands followed by installing nginx and checking of nginx 
 ```
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install nginx
sudo systemctl status nginx
```

- Step 7: nginx status active should load nginx in the browswer with `192.168.10.100` as well as http://development.local/

- Step 8: `vagrant halt` to pause the VM

## Reloading or destroying 
1. `vagrant reload` 
2. If vagrant reload doesn't work then `vagrant destroy` and `vagrant up` again
3. `vagrant ssh` Opens VM
4. `systemctl status nginx`
5. Go to browser and write `http://development.local`


## Automating the nginx server

- Create a file called `provision.sh` this is done by typing `sudo nano provision.sh`
- add `#!/bin/bash` at the top every time
- Add the instructions below
```
- `sudo apt-get update -y`
- `sudo apt-get upgrade -y`
- `sudo apt-get install nginx`
- `systemctl status nginx`

```

- To run provision.sh we need to give file permission and make this file executable
- To change permission we use `chmod` with required permission then file name
- `chmod` +x provision.sh`
- `sudo chmod +x provision.sh` changes permission as admin. Filename turns green when completed.
- To run it use `sudo ./provision.sh`

## Extra Linux Features

- Wildcards * can be used to select everything with certain extension etc, `rm -rf *.txt` will delete all txt files
- To end a process (ps aux shows list of running processes) use `sudo kill <PID number>`
- Pike symbol | can be used to search specific files

## Synced Folders
- Step 1: Create `provision.sh` file and insert the lines from automating nginx above
- Step 2: Add the following code to the vagrantfile `config.vm.synced_folder " (Path to a directory on host machine) ", "(absolute path of where to share the folder within the guest machine) "`
or `.` in the first bracket to sync everything from the current location
Step 3: The following code will run the provision file  `config.vm.provision "shell", path:"./PATH/provision.sh"` 

## Tests and commands
#### Variables
- Show all environment variables `env`
- Create a variable `export name=Saim`
- Find specific variable `printenv name`

## Tests 
On Host machine, inside spec-tests folder

- `gem install bundler to install bundler`
- `bundle` to run bundle and get dependencies
- `rake spec` to run tests

On Virtual Machine

- `curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -` and `sudo apt-get install nodejs` installs nodejs version 6
- `sudo apt-get install python-software-properties` to install all python dependencies
- `sudo npm install pm2 -g` installing pm2
- Add an environmental variable permanently `sudo echo 'export DB_HOST=mongodb' >> .profile` use echo or nano.

#### nodejs automation
- Add all of the commands above to the provision.sh file and run `vagrant reload`

## nginx reverse proxy
- `cd /etc`
- `cd nginx`
- `cd sites-available`
- `sudo nano default` or `sudo rm -rf default` and remake default file 
- `sudo nginx -t`
- `sudo systemctl status nginx`
- Navigate to app folder `cd`
- if errors occur kill some files `ps aux` and `sudo kill []` id in brackets

## Automating 2 VMs and mongodb installation
### Vagrant file differentiates between the two boxes
```
Vagrant.configure("2") do |config|
    
    config.vm.define "app" do |app|
        app.vm.box = "ubuntu/xenial64"
        app.vm.network "private_network", ip: "192.168.10.100"
        app.hostsupdater.aliases = ["development.local"]
        app.vm.synced_folder ".", "/home/vagrant/environment"
        app.vm.provision "shell", path: "./environment/app/provision.sh", env: {'DB_HOST' => 'mongodb://192.168.10.150:27017/posts'}
    end

    config.vm.define "db" do |db|
        db.vm.box = "ubuntu/xenial64"
        db.vm.network "private_network", ip: "192.168.10.150"
        db.vm.provision "shell", path: "./environment/db/provision.sh"
    end
end
```




