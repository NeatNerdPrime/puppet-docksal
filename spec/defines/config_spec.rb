require 'spec_helper'

describe 'docksal::config' do
  let(:title) { 'username' }
  let(:params) do
    {
      ci: false,
      native_docker: false,
      katacoda: false,
      stats_optout: false,
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it do
        is_expected.to contain_file('/home/username/.docksal').with('ensure' => 'directory')
      end
    end
  end
end
