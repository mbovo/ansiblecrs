
Vagrant.configure("2") do |config|

VAGRANT_ROOT = File.dirname(File.expand_path(__FILE__))
NODES = 2
DISKS = 1
DISK_SIZE = 10
#IMAGE = "bento/centos-7.6"
IMAGE = "bento/ubuntu-18.04"

  config.vm.define "orchestrator" do |orc|
    orc.ssh.forward_agent = true
    orc.vm.box = IMAGE
    orc.vm.hostname = "orchestrator"
    orc.vm.network "private_network", ip: "192.168.60.5", netmask: "255.255.255.0"
    orc.vm.provider "virtualbox" do |vb|
      vb.name = "vg_ansiblecrs_orchestrator"
      vb.memory = 1024
      vb.cpus = 2
    end  
  end

  (1..NODES).each do |i|
    config.vm.define "node#{i}" do |node|
      node.ssh.forward_agent = true
      node.vm.box = IMAGE
      node.vm.hostname = "node#{i}"
      node.vm.network "private_network", ip: "192.168.60.#{i}0", netmask: "255.255.255.0"
      node.vm.provision :shell, inline: "sed 's/127\.0\.0\.1.*node.*/192\.168\.60\.#{i}0 node#{i}/' -i /etc/hosts"
      node.vm.provider "virtualbox" do |vb|
        vb.name = "vg_ansiblecrs_node#{i}"
        vb.memory = 2240
        vb.cpus = 2
        
        (1..DISKS).each do |k|
          
          more_disk = File.join(VAGRANT_ROOT, "DATA/node#{i}_disk#{k}.vdi")
          unless File.exist?(more_disk)
            vb.customize ['createhd', '--filename', more_disk, '--size', DISK_SIZE * 1024]
          end
          vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', k+1, '--device', 0 , '--type', 'hdd', '--medium', more_disk]
          
         end
 
      end 
    end
  end

  # config.vm.provision "ansible" do |key|
  #   key.playbook = "./ansible/addkey.yml"
  #   key.extra_vars = {
  #     myhosts: "all"
  #   }
  # end  

end
