$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'reaper'
require 'fileutils'
require 'ostruct'


def make_temp_dir
  relative_path = File.join(File.dirname(__FILE__), '..', 'tmp')

  FileUtils.mkdir_p(File.expand_path(relative_path))
end

def capture_output_of
  streams = OpenStruct.new(stdout: $stdout, stderr: $stderr)

  $stdout, $stderr = StringIO.new, StringIO.new

  yield

  OpenStruct.new(stdout: $stdout, stderr: $stderr)
ensure
  $stdout, $stderr = streams.stdout, streams.stderr
end
