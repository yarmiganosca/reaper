require 'spec_helper'

module Reaper
  describe Gem do
    before { make_temp_dir }

    describe '#build' do
      before do
        capture_output_of do
          Gem.new(gem_name, {path: path}).build
        end
      end
      after { FileUtils.remove_dir(gem_dir) }

      let(:gem_dir)  { File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'tmp', 'dummy')) }
      let(:gem_name) { 'dummy' }
      let(:path)     { File.dirname(gem_dir) }

      it 'builds a gem' do
        expect(Dir.exists?(gem_dir)).to eq true
      end
    end
  end
end
