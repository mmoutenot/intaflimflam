desc 'Run the app'
task :s do
  system "bundle exec shotgun config.ru -p 4567"
end
