require 'bundler/setup'
require 'rspec/core/rake_task'

# spec

desc 'Run RSpec tests'
RSpec::Core::RakeTask.new(:spec) do |task|
  task.pattern    = 'spec/**/*_spec.rb'
end

# mutant

desc 'Run Mutant against RSpec tests'
task :mutant, [:rand] do |task, args|
  paths_to_check = Dir['lib/**/*.rb'] - Dir['lib/dummy_load/**/*']

  paths_to_check.shuffle! if /^rand/.match(args.rand)
  paths_to_check.each do |path|
    puts path_to_require(path)
    puts path_to_class(path)
    ruby '-S', 'mutant', '--rspec',
         '--fail-fast',
         '-Iconfig',
         '-Ilib',
         "-r#{path_to_require(path)}",
         path_to_class(path)
  end
end

# clean

desc 'Clean out YARD and SimpleCov directories'
task :clean do
  rm_rf %w(.yardoc coverage doc)
end

task :all => [ :spec ]
task :default => [ :all ]

###############################################################################

private

def path_to_class(path)
  # rubocop:disable PerlBackrefs

  class_name = path_to_require(path)
  class_name.gsub!('/', '::')
  class_name.gsub!('_json', 'JSON')

  class_name.gsub!(/(?:^|_)([a-z]+)/i) do |match|
    (match == '_backend' ? match : $1.capitalize)
  end

  class_name.gsub!(/::([a-z])/i) { |match| '::' + $1.upcase }
  class_name

  # rubocop:enable PerlBackrefs
end

def path_to_require(path)
  %r{^lib/(.*)\.rb$}.match(path)[1]
end
