# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'coffeescript', :input => 'www/js/src', :output => 'www/js/compiled', :bare => true
guard 'coffeescript', :input => 'www/spec/helpers', :output => 'www/spec/helpers', :bare => true

guard 'haml', :output => 'www', :input => 'www/view' do
	watch %r{^www/.+(\.html\.haml)}
end

guard 'sass', :input => 'www/css/src', :output => 'www/css/compiled'
