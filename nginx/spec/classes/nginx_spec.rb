# frozen_string_literal: true
# spec/classes/init_spec.rb

require 'spec_helper'
describe 'nginx' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      it { is_expected.to compile }
      it { is_expected.to contain_service('nginx').that_requires('Package[nginx]') }
    end
  end
end
~
