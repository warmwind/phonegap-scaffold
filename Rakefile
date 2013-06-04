require 'fileutils'

%w(ios android).each do |platform|
  namespace platform.to_sym do
    %w(build emulate log release run).each do |cmd|
      desc "run platform/#{platform}/cordova/#{cmd}"
      task cmd.to_sym => "copy_to_#{platform}".to_sym do
        sh "platform/#{platform}/cordova/#{cmd}"
      end
    end
  end
end

task :copy_to_ios do
  FileUtils.cp_r 'www/', 'platform/ios/'
  FileUtils.cp 'platform/cordova-2.5.0-ios.js', 'platform/ios/www/cordova-2.5.0.js'
end

task :copy_to_android do
  FileUtils.cp_r 'www/', 'platform/android/assets/'
  FileUtils.cp 'platform/cordova-2.5.0-android.js', 'platform/android/assets/www/cordova-2.5.0.js'
end

require 'erb'
require 'json'
require 'yaml'
desc "set up api server by setting url or from env"
task :set_env, :url do |t, args|
  build_env = ENV['BUILD_ENV'] || 'development'
  server = YAML.load_file "server_config.yml"
  server_url=  args[:url] || server[build_env]
  processed = ERB.new(File.new("app_template.coffee.erb").read).result(binding)
  File.open('www/js/src/app.coffee', 'w+') {|f| f.write(processed) }
  p "set api config server to #{build_env}: #{server_url}"
end

############# tasks for jasmine #############

require 'jasmine-headless-webkit'

Jasmine::Headless::Task.new('jasmine:headless') do |t|
  t.colors = true
  t.keep_on_error = true
  t.jasmine_config = 'www/spec/support/jasmine.yml'
end

############# tasks for compiling #############

require 'coffee-script'

namespace :coffee do

  desc 'Compile source coffeescript files'
  task :compile do
    src_dir = File.expand_path('../www/js/src', __FILE__)
    compiled_dir = File.expand_path('../www/js/compiled', __FILE__)
    files = Dir.glob(File.join(src_dir, '*.coffee'))
    FileUtils.remove_dir compiled_dir if Dir.exists? compiled_dir
    FileUtils.mkdir compiled_dir
    files.each do |file|
      compiled_js = CoffeeScript.compile File.read(file), :bare => true
      output_js = "#{compiled_dir}/#{File.basename file, '.*'}.js"
      File.open(output_js, 'w+') { |f| f.write(compiled_js) }
      puts "#{output_js} created"
    end
  end
end

require 'sass'

namespace :scss do

  desc 'Compile source scss files'
  task :compile do
    src_dir = File.expand_path('../www/css/src', __FILE__)
    compiled_dir = File.expand_path('../www/css/compiled', __FILE__)
    files = Dir.glob(File.join(src_dir, '*.css.scss'))
    FileUtils.remove_dir compiled_dir if Dir.exists? compiled_dir
    FileUtils.mkdir compiled_dir
    files.each do |file|
      compiled = `scss #{file}`
      output = "#{compiled_dir}/#{File.basename file, '.*'}"
      File.open(output, 'w+') { |f| f.write(compiled) }
      puts "#{output} created"
    end
  end
end

require 'haml'

namespace :haml do

  desc 'Compile source haml files'
  task :compile do
    src_dir = File.expand_path('../www/view', __FILE__)
    compiled_dir = File.expand_path('../www/', __FILE__)
    files = Dir.glob(File.join(src_dir, '*.haml'))
    files.each do |file|
      compiled_html = `haml #{file}`
      output_html = "#{compiled_dir}/#{File.basename file, '.*'}"
      File.open(output_html, 'w+') { |f| f.write(compiled_html) }
      puts "#{output_html} created"
    end
  end
end

task :compile_all => ['haml:compile', 'coffee:compile', 'scss:compile']

task :default => ['compile_all', 'jasmine:headless']

