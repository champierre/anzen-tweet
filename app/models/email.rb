class Email < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  include Rails.application.routes.url_helpers
  default_url_options[:host] = ENV['HOST_NAME']

  def tweet
    tauth = Twitter::OAuth.new(ENV['CONSUMER_TOKEN'], ENV['CONSUMER_SECRET'])
    tauth.authorize_from_access(ENV['ACCESS_TOKEN'], ENV['ACCESS_SECRET'])
    client = Twitter::Base.new(tauth)
    client.update("#{truncate(body, :length => 100)} #{email_url(self)}")
  end
end
