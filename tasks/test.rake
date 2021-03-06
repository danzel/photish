require "rspec/core/rake_task"
require 'cucumber'
require 'cucumber/rake/task'

desc 'Run all tests'
task :test => ['test:spec',
               'test:features']

namespace :test do
  desc 'Clean up test fodlers'
  task :clean do
    sh "rm -rf tmp/aruba"
  end

  RSpec::Core::RakeTask.new(:spec)

  Cucumber::Rake::Task.new(:features) do |t|
    tags = ['']
    tags << '--tags ~@wip'
    tags << '--tags @smoke' if ENV['SMOKE_TEST_ONLY']
    t.cucumber_opts = "features --format pretty #{tags.join(' ')}"
  end

  desc 'Test packaged binary in docker'
  task :integration do
    sh './boxes/test.sh'
  end
end
