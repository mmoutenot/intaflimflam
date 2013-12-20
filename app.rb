require 'sinatra'
require 'instagram'

class InstaMasher < Sinatra::Base
  require './helpers/render_partial'
  enable :sessions
  configure(:development) { set :session_secret, "something" }

  CALLBACK_URL = 'http://cathoderaytube.herokuapp.com/oauth/callback'

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

  get '/subscription/callback' do
    if params['hub.challenge']
      render :text => params['hub.challenge']
    else
      puts 'Callback!'
      puts params
      # PrivatePub.publish_to("/subscriptions/tag/#{params[:object_id]}", payload: params[:_json])
    end
  end

  get '/videos' do
    content_type :json
    # client = Instagram.client(:access_token => session[:access_token])
    # videos = []
    # client.tag_recent_media('video').each do |m|
    #   # redis.setnx "#{m.id}", m.videos.standard_resolution.url if m.videos
    #   videos << {:id => m.id, :url => m.videos.standard_resolution.url} if m.videos
    # end

    Thread.new do |t|
      options = {:object_id => 'video'}
      Instagram.create_subscription('tag', "http://cathoderaytube.herokuapp.com/subscription/callback", aspect = 'media', options)
      t.exit
    end

    puts videos.to_json
    videos.to_json
  end

end
