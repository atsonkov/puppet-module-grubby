require 'spec_helper'

describe 'grubby::kernel_opt' do
  let(:title) { 'foo' }

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) do
        os_facts
      end

      it { is_expected.to compile }
      context 'with no parameters' do
        it do
          is_expected.to contain_exec('Ensure foo kernel option is set for DEFAULT').with(
            command: '/sbin/grubby --update-kernel=DEFAULT --args=foo',
            unless: '/sbin/grubby --info=DEFAULT | grep ^args= | test -z "$(grep -wv foo)"',
          )
        end
        context 'with value and scope set' do
          let(:params) do
            { value: 'bar', scope: 'ALL' }
          end

          it do
            is_expected.to contain_exec('Ensure foo=bar kernel option is set for ALL').with(
              command: '/sbin/grubby --update-kernel=ALL --args=foo=bar',
              unless: '/sbin/grubby --info=ALL | grep ^args= | test -z "$(grep -wv foo=bar)"',
            )
          end
        end
        context 'with value set as an array' do
          let(:params) do
            { value: ['alpha', 'beta', 'gamma'] }
          end

          it do
            is_expected.to contain_exec('Ensure foo="alpha beta gamma" kernel option is set for DEFAULT').with(
              command: '/sbin/grubby --update-kernel=DEFAULT --args=foo="alpha beta gamma"',
              unless: '/sbin/grubby --info=DEFAULT | grep ^args= | test -z "$(grep -wv foo="alpha beta gamma")"',
            )
          end
        end
      end
      context 'with ensure absent parameters' do
        let(:params) do
          { ensure: 'absent' }
        end

        it do
          is_expected.to contain_exec('Ensure foo kernel option is absent for DEFAULT').with(
            command: '/sbin/grubby --update-kernel=DEFAULT --remove-args=foo',
            unless: '/sbin/grubby --info=DEFAULT | grep ^args= | test -z "$(grep -w foo)"',
          )
        end
        context 'with value and scope set' do
          let(:params) do
            super().merge(value: 'bar', scope: 'ALL')
          end

          it do
            is_expected.to contain_exec('Ensure foo kernel option is absent for ALL').with(
              command: '/sbin/grubby --update-kernel=ALL --remove-args=foo',
              unless: '/sbin/grubby --info=ALL | grep ^args= | test -z "$(grep -w foo)"',
            )
          end
        end
        context 'with value set as an array' do
          let(:params) do
            super().merge(value: ['alpha', 'beta', 'gamma'])
          end

          it do
            is_expected.to contain_exec('Ensure foo kernel option is absent for DEFAULT').with(
              command: '/sbin/grubby --update-kernel=DEFAULT --remove-args=foo',
              unless: '/sbin/grubby --info=DEFAULT | grep ^args= | test -z "$(grep -w foo)"',
            )
          end
        end
      end
    end
  end
end
