#!/usr/bin/env ruby

def _run(cmd)
  puts cmd
  system cmd
end

_run 'gem install bundler --no-rdoc --no-ri'
_run 'bundle install'
print 'Input App Name:'
app_name = STDIN.gets
app_name.chop!
print 'Input Consumer Key:'
consumer_token = STDIN.gets
consumer_token.chop!
print 'Input Consumer Secret:'
consumer_secret = STDIN.gets
consumer_secret.chop!
print 'Input Access Token:'
access_token = STDIN.gets
access_token.chop!
print 'Input Access Token Secret:'
access_secret = STDIN.gets
access_secret.chop!
_run "heroku create #{app_name}"
_run "heroku addons:add cloudmailin:test"
_run "heroku config:add ACCESS_SECRET=#{access_secret} ACCESS_TOKEN=#{access_token} CONSUMER_SECRET=#{consumer_secret} CONSUMER_TOKEN=#{consumer_token} HOST_NAME=#{app_name}.heroku.com"
_run "git add ."
_run "git commit -a -m 'initial commit to heroku'"
_run "git push heroku master"
_run "heroku rake db:migrate"
puts "Log in cloudmailin and set http://#{app_name}.heroku.com/emails as the target."
_run "open https://api.heroku.com/myapps/#{app_name}"
