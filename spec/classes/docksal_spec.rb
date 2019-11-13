require 'spec_helper'

describe 'docksal' do
  let(:params) do
    {
      version: 'v1.12.3',
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it do
        is_expected.to contain_file('/usr/local/bin/fin-v1.12.3').with(
          'ensure' => 'file',
          'mode' => '0755',
        )

        is_expected.to contain_file('/usr/local/bin/fin').with(
          'ensure' => 'link',
          'target' => '/usr/local/bin/fin-v1.12.3',
        )
      end
    end
  end
end
