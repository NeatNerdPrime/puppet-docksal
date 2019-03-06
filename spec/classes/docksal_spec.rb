require 'spec_helper'

describe 'docksal' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it do
        is_expected.to contain_file('/usr/local/bin/fin').with(
          'ensure' => 'file',
          'mode' => '0755',
        )
      end
    end
  end
end
