require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the Mighty Associations plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the Mighty Associations plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Mighty Associations'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

namespace :gem do
  desc "Increments the Gem version in mighty_associations.gemspec"
  task :increment do
    lines = File.new('mighty_associations.gemspec').readlines
    lines.each do |line|
      next unless line =~ /version = "\d+\.\d+\.(\d+)"/
      line.gsub!(/\d+"/, "#{$1.to_i + 1}'")
    end
    File.open('mighty_associations.gemspec', 'w') do |f|
      lines.each do |line|
        f.write(line)
      end
    end
  end
end