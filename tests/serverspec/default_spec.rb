require 'spec_helper'
require 'serverspec'

package = 'blynk'
service = 'blynk'
config_dir = "/etc/blynk"
user    = 'www-data'
group   = 'www-data'
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
bin     = "#{ home_dir }/blynk.jar"

case os[:family]
when 'freebsd'
  config_dir = "/usr/local/etc/blynk"
  db_dir = '/var/db/blynk'
  user   = "www"
  group  = "www"
end

config  = "#{ config_dir }/server.properties"
cert    = "#{ config_dir }/cert.pem"
key     = "#{ config_dir }/key.pem"
mail_config = "#{ home_dir }/mail.properties"

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

describe file(cert) do
  it { should be_file }
  it { should be_mode 644 }
end

describe file(key) do
  it { should be_file }
  it { should be_mode 640 }
  it { should be_grouped_into group }
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

describe command("echo '' | openssl s_client -connect 127.0.0.1:7443") do
  its(:stdout) { should match(/^CONNECTED\(\d+\)$/) }
  its(:stdout) { should match(/^Server public key is 2048 bit$/) }
  its(:stdout) { should match(/^\s+Protocol\s+:\s+TLSv1\.2$/) }
  its(:stdout) { should match(/^MIIDhTCCAm2gAwIBAgIJANoweLcD5utMMA0GCSqGSIb3DQEBCwUAMFkxCzAJBgNV$/) }

  its(:stderr) { should match(/^depth=0 C = AU, ST = Some-State, O = Internet Widgits Pty Ltd, CN = localhost$/) }
  its(:stderr) { should match(/^verify error:num=18:self signed certificate$/) }
end

describe file(mail_config) do
  it { should be_file }
  its(:content) { should match(/^mail.smtp.auth=true$/) }
  its(:content) { should match(/^mail.smtp.starttls.enable=true$/) }
  its(:content) { should match(/^mail.smtp.host=smtp\.gmail\.com$/) }
  its(:content) { should match(/^mail.smtp.port=587$/) }
  its(:content) { should match(/^mail.smtp.username=username$/) }
  its(:content) { should match(/^mail.smtp.password=password$/) }
end
