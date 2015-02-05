$new_discovery_url='https://discovery.etcd.io/new'

# Automatically replace the discovery token on 'vagrant up'
if File.exists?('user-data') && ARGV[0].eql?('up')
  require 'open-uri'
  require 'yaml'

  token = open($new_discovery_url).read

  data = YAML.load(IO.readlines('user-data')[1..-1].join)
  data['coreos']['etcd']['discovery'] = token

  yaml = YAML.dump(data)
  File.open('user-data', 'w') { |file| file.write("#cloud-config\n\n#{yaml}") }
end


# Size of the CoreOS cluster created by Vagrant
$num_instances=1

# Change basename of the VM
# The default value is "core", which results in VMs named starting with
# "core-01" through to "core-${num_instances}".

# Official CoreOS channel from which updates should be downloaded
$update_channel='stable'

# Enable port forwarding of Docker TCP socket
# Set to the TCP port you want exposed on the *host* machine, default is 2375
# If 2375 is used, Vagrant will auto-increment (e.g. in the case of $num_instances > 1)
# You can then use the docker tool locally by setting the following env var:
# export DOCKER_HOST='tcp://127.0.0.1:2375'
$expose_docker_tcp=2375

# Customize VMs
$vm_gui = false
$vm_memory = 6144
$vm_cpus = 4
