# frozen_string_literal: true

require 'spec_helper'

describe 'grubby' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      it { is_expected.to create_class('grubby') }

      it { is_expected.to contain_class('grubby::config') }

      it_behaves_like 'grubby::config', os_facts

    end
  end
end
