require 'spec_helper'

describe 'unbound::config' do
  let(:title) { 'namevar' }
  let(:params) do
    {
      content: 'Puppet was here',
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it {
        is_expected.to contain_file('/etc/unbound/conf.d/namevar.conf')
          .with_content('Puppet was here')
      }
    end
  end
end
