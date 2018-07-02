Vagrant.configure("2") do |config|

  # Define Single Node Cluster Elasticnode
  config.vm.define "es_node_01" do |es_node_01|
    es_node_01.vm.synced_folder "./vagrant", "/vagrant"
    es_node_01.vm.box = "ol7-latest"
    es_node_01.vm.hostname = 'es-node-01'
    es_node_01.vm.box_url = "https://yum.oracle.com/boxes/oraclelinux/latest/ol7-latest.box"
    es_node_01.vm.network :"private_network", type: "dhcp"
    es_node_01.vm.network "forwarded_port", guest: 9200, host: 9200, protocol: "tcp"
    es_node_01.vm.network "forwarded_port", guest: 5601, host: 5601, protocol: "tcp"
    es_node_01.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", 1024]
      v.customize ["modifyvm", :id, "--cpus", "2"]
      v.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
      v.customize ["modifyvm", :id, "--usb", "off"]
      v.customize ["modifyvm", :id, "--audio", "none"]
      v.customize ["modifyvm", :id, "--name", "es_node_01"]
    end # End of "es_node_01.vm.provider"
  end   # End of config.vm.define "es_node_01"


    # Set auto_update to false
    # This will not automatically update the guest additions on VM boot
    # Set to "true" if you want auto-updates
    # config.vbguest.auto_update = false

    # Run the same playbook on all hosts
    # :vars section provided as example on passing variables to
    # ansible in possible future versions
    config.vm.provision "ansible_local" do |ansible|
          ansible.verbose = "v"
          ansible.playbook = "ansible-playbook.yml"
          ansible.groups = {
            "elasticnodes" => ["es_node_01"],
            "elasticnodes:vars" => {"variable1" => "example1",
                                    "variable2" => "example2"}
          }
    end   # End of "config.vm.provision"

end       # End of "Vagrant.configure"
