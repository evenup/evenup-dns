require 'spec_helper'

describe 'dns::forwarder', :type => :class do
  let(:facts) { {
    :ipaddress => '1.2.3.4',
    :fqdn => 'somehost.example.org',
    :hostname => 'somehost'
  } }

  let(:params) { {
    :forwarders => '1.2.3.4;',
    :allow_query => '4.3.2.1/16;'
  } }

  it { should create_class('dns::forwarder') }

  it { should contain_package('bind') }
  it { should contain_file('/etc/named.conf').with(:content => /forwarders\s+\{ 1.2.3.4; \};/ ) }
  it { should contain_file('/etc/named.conf').with(:content => /allow\-query\s+\{ 4.3.2.1\/16; \};/ ) }
  it { should contain_service('named').with(:ensure => 'running', :enable => true) }

end
