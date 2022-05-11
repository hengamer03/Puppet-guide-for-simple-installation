Vagrant.configure("2") do |config|

  config.vm.define :puppetserver do |puppetserver|
	  puppetserver.vm.box = "generic/rhel8"
	  puppetserver.vm.hostname = "puppet.example.com"
	  puppetserver.vm.provider :hyperv do |hyperv|
                hyperv.maxmemory = 4096
                hyperv.memory = 4096 
	        hyperv.cpus = 2
 	  end
  end

  config.vm.define :puppetagent01 do |puppetagent|
   	  puppetagent.vm.box = "generic/rhel8"
	  puppetagent.vm.hostname = "puppetagent01.example.com"
	  puppetagent.vm.provider :hyperv do |hyperv|
                hyperv.maxmemory = 2048
                hyperv.memory = 2048
                hyperv.cpus = 2
        end
  end
end

#if you use any other virtualization program like Virtualbox replace hyperv with virtualbox, the work in between the pipes is the variable so you can type in
#   puppetagent.vm.provider :virtualbox do |vb|
#if you do this remember to replace the fields under with the variable first
#  (yourvar).maxmemory = 2048 
