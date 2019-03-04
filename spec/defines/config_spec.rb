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

      context "docksal class without any parameters" do
        it { is_expected.to compile }
        it do
          is_expected.to contain_file('/home/username/.docksal').with('ensure' => 'directory')
        end

        it do
          is_expected.to contain_file('/home/username/.docksal/docksal.env').with({
            :ensure => 'file',
            :content => /^$/,
          }).that_requires('File[/home/username/.docksal]')
        end
      end

      context "docksal class with ci set" do
        let(:params) { super().merge(:ci => true) }
        it do
          is_expected.to contain_file('/home/username/.docksal/docksal.env').with({
            :ensure => 'file',
            :content => /CI=1\n/,
          }).that_requires('File[/home/username/.docksal]')
        end
      end

      context "docksal class with native_docker set" do
        let(:params) { super().merge(:native_docker => true) }
        it do
          is_expected.to contain_file('/home/username/.docksal/docksal.env').with({
            :ensure => 'file',
            :content => /DOCKER_NATIVE=1\n/,
          }).that_requires('File[/home/username/.docksal]')
        end
      end

      context "docksal class with katacoda set" do
        let(:params) { super().merge(:katacoda => true) }
        it do
          is_expected.to contain_file('/home/username/.docksal/docksal.env').with({
            :ensure => 'file',
            :content => /KATACODA=1\n/,
          }).that_requires('File[/home/username/.docksal]')
        end
      end

      context "docksal class with stats_optout set" do
        let(:params) { super().merge(:stats_optout => true) }
        it do
          is_expected.to contain_file('/home/username/.docksal/docksal.env').with({
            :ensure => 'file',
            :content => /DOCKSAL_STATS_OPTOUT=1\n/,
          }).that_requires('File[/home/username/.docksal]')
        end
      end
    end
  end
end
