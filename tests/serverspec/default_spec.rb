require 'spec_helper'
require 'serverspec'

package = 'blynk'
service = 'blynk'
config  = '/etc/blynk/server.properties'
user    = 'blynk'
group   = 'blynk'
ports   = [
  7443,
  8080,
  8081,
  8082,
  8441,
  8442,
  8443,
  9443,
]
log_dir = '/var/log/blynk'
db_dir  = '/var/lib/blynk'
home_dir= "/usr/local/blynk"
bin     = "#{ home_dir }/server.jar"

case os[:family]
when 'freebsd'
  config = '/usr/local/etc/blynk/server.properties'
  db_dir = '/var/db/blynk'
  user   = "www"
  group  = "www"
end

describe file(home_dir) do
  it { should be_directory }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end 

describe file(bin) do
  it { should be_file }
  it { should be_mode 755 }
end

describe file(config) do
  it { should be_file }
end

describe file(log_dir) do
  it { should exist }
  it { should be_mode 755 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

describe file(db_dir) do
  it { should exist }
  it { should be_mode 755 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

%w[ blynk.log postgres.log stats.log worker.log ].each do |f|
  describe file("#{ log_dir }/#{f}") do
    it { should be_file }
  end
end

=begin
case os[:family]
when 'freebsd'
  describe file('/etc/rc.conf.d/blynk-server') do
    it { should be_file }
  end
end
=end

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end

ports.each do |p|
  describe port(p) do
    it { should be_listening }
  end
end
