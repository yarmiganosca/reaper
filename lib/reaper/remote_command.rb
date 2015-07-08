require 'stringio'
require 'ostruct'

module Reaper
  class RemoteCommand
    def initialize
      @blk = proc
    end

    def run_from(path)
      dir = Dir.pwd

      Dir.chdir(path)
      
      @blk.call
    ensure
      Dir.chdir(dir)
    end
  end
end
