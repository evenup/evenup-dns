require 'spec_helper'

describe 'dns', :type => :class do
  let(:facts) { { :domain => 'example.org', :ipaddress => '1.2.3.4', :fqdn => 'somehost.example.org', :hostname => 'somehost' } }

  it { should create_class('dns') }

  it { should contain_package('bind-utils') }
  it { should contain_file('/etc/resolv.conf') }
  it { should contain_file('/etc/hosts') }

  context 'allow disabling resolv.conf' do
    let(:params) { { :resolv => false } }
    it { should_not contain_file('/etc/resolv.conf') }
  end

end
