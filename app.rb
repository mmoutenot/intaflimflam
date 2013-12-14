require 'sinatra'
require 'instagram'
class InstaMasher < Sinatra::Base
  require './helpers/render_partial'
  enable :sessions
  configure(:development) { set :session_secret, "something" }

  CALLBACK_URL = 'http://localhost:4567/oauth/callback'

  Instagram.configure do |config|
    config.client_id = 'a5cf5a8ec091425dbca8eb0ffda482c2'
    config.client_secret = '1c39d51507964984b3af9642420292ec'
  end

  get '/' do
    redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL) unless session[:access_token]
    haml :tv
  end

  get '/oauth/connect' do
    redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
  end

  get '/oauth/callback' do
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
    session[:access_token] = response.access_token
    redirect '/'
  end

  get '/videos' do
    content_type :json
    client = Instagram.client(:access_token => session[:access_token])

    videos = []
    recent_media = client.tag_recent_media('jamielidell')
    recent_media.each do |m|
      videos << {
        :id => m.id,
        :url => m.videos.standard_resolution.url,
        :playing => (index == recent_media.size()-1)
      } if m.videos
    end

    puts videos.to_json
    videos.to_json
  end

end
