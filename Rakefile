require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'rake/clean'
require 'rubygems'
require 'rubygems/package_task'
require 'rdoc/task'
require 'cucumber'
require 'cucumber/rake/task'

Rake::RDocTask.new do |t|
  t.main  = "README.md"
  t.title = 'Reaper'

  t.rdoc_files.include("README.md", "lib/**/*.rb", "bin/**/*")
end

spec = eval(File.read('reaper.gemspec'))

Gem::PackageTask.new(spec) { |pkg| }

CUKE_RESULTS = 'results.html'

CLEAN << CUKE_RESULTS

desc 'Run features'
Cucumber::Rake::Task.new(:features) do |t|
  opts = "features --format html -o #{CUKE_RESULTS} --format progress -x"
  opts += " --tags #{ENV['TAGS']}" if ENV['TAGS']

  t.cucumber_opts = opts
  t.fork          = false
end

desc 'Run features tagged as work-in-progress (@wip)'
Cucumber::Rake::Task.new('features:wip') do |t|
  tag_opts        = ' --tags ~@pending'
  tag_opts        = ' --tags @wip'
  t.cucumber_opts = "features --format html -o #{CUKE_RESULTS} --format pretty -x -s#{tag_opts}"
  t.fork          = false
end

task :cucumber      => :features
task 'cucumber:wip' => 'features:wip'
task :wip           => 'features:wip'

RSpec::Core::RakeTask.new(:spec)

task :default => [:spec, :features]

