require 'spec_helper'

class ServiceNotReady < StandardError
end

context 'after provisioning finished' do
  describe server(:client1) do
    it 'should be able to ping server' do
      result = current_server.ssh_exec("ping -c 1 #{ server(:server1).server.address } && echo OK")
      expect(result).to match(/OK/)
    end
  end

  describe server(:server1) do
    it 'should be able to ping client' do
      result = current_server.ssh_exec("ping -c 1 #{ server(:client1).server.address } && echo OK")
      expect(result).to match(/OK/)
    end
  end

  describe server(:server1) do
    describe capybara("https://192.168.21.200:7443") do
      it "shows admin page" do
        visit "/admin#/dashboard"
        expect(page).to have_title "Blynk Administration"
      end
    end
  end
end
