require 'bundler'
require 'bundler/cli'
require 'bundler/cli/gem'
require 'thor'
require 'reaper/remote_command'
require 'ostruct'

module Reaper
  class Gem
    def initialize(name, options)
      @name            = name
      @bundler_options = options.fetch(:bundler_options) { {} }
      @run_from_path   = options.fetch(:path) { Dir.pwd }
    end

    def build
      RemoteCommand.new do
        Bundler::CLI::Gem.new(@bundler_options, @name, bundler_cli).run
      end.run_from(@run_from_path)
    end

    private

    def bundler_cli
      Bundler::CLI.new([], [], {current_command: OpenStruct.new(name: 'gem')})
    end
  end
end

      
