require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'resolvconf class' do

  context 'basic setup' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOF

      class { 'resolvconf':
      }

      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    describe file($resolvfile) do
      it { should be_file }
      its(:content) { should match 'puppet managed file' }
      its(:content) { should match 'nameserver 8.8.8.8' }
      its(:content) { should match 'nameserver 8.8.4.4' }
    end

  end
end
