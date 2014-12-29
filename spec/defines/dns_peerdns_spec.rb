require 'spec_helper'

describe 'dns::peerdns', :type => :define do
  let(:facts) { {
    :ipaddress => '1.2.3.4',
    :fqdn => 'somehost.example.org',
    :hostname => 'somehost'
  } }

  let(:title) { 'eth0' }
  let(:pre_condition) { 'include dns' }

  it { should contain_file_line('ifcfg-eth0-peerdns-y').with_ensure('absent') }
  it { should contain_file_line('ifcfg-eth0-peerdns-n') }

  context "when present = yes" do
    let(:params) { { :present => 'yes' } }
    it { should contain_file_line('ifcfg-eth0-peerdns-n').with_ensure('absent') }
    it { should contain_file_line('ifcfg-eth0-peerdns-y') }
  end

end
