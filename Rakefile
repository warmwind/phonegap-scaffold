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

  desc 'Compiles and concatenates source coffeescript files'
  task :compile do
    SRC_DIR = File.expand_path('../www/js/src', __FILE__)
    COMPILED_DIR = File.expand_path('../www/js/compiled', __FILE__)
    files = Dir.glob(File.join(SRC_DIR, '*.coffee'))
    FileUtils.remove_dir COMPILED_DIR if Dir.exists? COMPILED_DIR
    FileUtils.mkdir COMPILED_DIR
    files.each do |file|
      compiled_js = CoffeeScript.compile File.read(file), :bare => true
      output_js = "#{COMPILED_DIR}/#{File.basename file, '.*'}.js"
      File.open(output_js, 'w+') { |f| f.write(compiled_js) }
      puts "#{output_js} created"
    end
  end
end

task :default => ['coffee:compile', 'jasmine:headless']

