shared_examples_for 'grubby::config' do |_default_facts|
  context 'default' do
    it { is_expected.to contain_class('grubby::config') }
    it { is_expected.not_to contain_exec('set default kernel') }

    context 'when default_kernel is defined' do
      let(:params) { { default_kernel: '2.6.32-431.23.3.el6.x86_64' } }

      it do
        is_expected.to contain_exec('set default kernel').with(command: '/sbin/grubby --set-default=/boot/vmlinuz-2.6.32-431.23.3.el6.x86_64',
                                                               path: ['/bin', '/usr/bin'],
                                                               unless: '/sbin/grubby --default-kernel | grep -q /boot/vmlinuz-2.6.32-431.23.3.el6.x86_64')
      end
    end
    context 'when kernel_opts is defined' do
      let(:params) do
        { kernel_opts: { 'foo' => {
          'ensure' => 'present', 'value' => 'ball', 'scope' => 'ALL'
        },
                         'bar' => {
                           'ensure' => 'present', 'value' => 10
                         } } }
      end

      it {
        is_expected.to contain_grubby__kernel_opt('foo').with(ensure: 'present',
                                                              value: 'ball',
                                                              scope: 'ALL')
      }
      it { is_expected.to contain_exec('Ensure bar=10 kernel option is set for DEFAULT') }

      it {
        is_expected.to contain_grubby__kernel_opt('bar').with(ensure: 'present',
                                                              value: 10,
                                                              scope: 'DEFAULT')
      }
      it { is_expected.to contain_exec('Ensure foo=ball kernel option is set for ALL') }
    end
  end
end
