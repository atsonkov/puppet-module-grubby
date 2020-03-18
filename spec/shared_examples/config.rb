shared_examples_for 'grubby::config' do |_default_facts|
  context 'default' do
    it { is_expected.to contain_class('grubby::config') }
    it { is_expected.not_to contain_exec('set default kernel') }

    context 'when grub_kernel_version defined' do
      let(:params) { { grub_default_kernel: '2.6.32-431.23.3.el6.x86_64' } }

      it do
        is_expected.to contain_exec('set default kernel').with(command: '/sbin/grubby --set-default=/boot/vmlinuz-2.6.32-431.23.3.el6.x86_64',
                                                               path: ['/bin', '/usr/bin'],
                                                               unless: '/sbin/grubby --default-kernel | grep -q /boot/vmlinuz-2.6.32-431.23.3.el6.x86_64')
      end
    end
  end
end
