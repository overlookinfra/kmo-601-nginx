# spec/classes/nginx_spec.rb
# frozen_string_literal: true

require 'spec_helper'

describe 'nginx' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it { is_expected.to contain_service('nginx').that_requires('Package[nginx]') }
      it { is_expected.to contain_service('nginx').that_subscribes_to('File[nginx_conf]') }
      it { is_expected.to contain_file('nginx_conf').with('content' => %r{worker_processes}) }
      it { is_expected.to contain_file('sites_enabled_dir') }
    end
  end
end
