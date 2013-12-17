require 'sinatra'
require 'sequel'
require 'dotenv'
require 'omniauth'
require 'omniauth-github'
require 'users'
require 'user'
require 'repos'
require 'repo'

Dotenv.load

::DB = Sequel.connect(ENV['DATABASE_URL'])

class App
  attr_reader :app

  def initialize
    @app = Rack::Builder.app do
      map('/') { run(Endpoint.new) }
    end
  end

  def call(env)
    app.call(env)
  end
end

class Endpoint < Sinatra::Base
  set :sessions, true

  #Configure OmniAuth
  use OmniAuth::Builder do
    provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET'],
      scope: 'user,repo,gist'
  end

  get('/auth/github/callback') do
    auth = env['omniauth.auth']
    puts auth
    unless Users.find(auth[:info][:nickname]).exists?
      u = User.new(login: auth[:info][:nickname], oauth_token: auth[:credentials][:token])
      Users.save(u)
    end
  end

  post('/repos/:user/:repo/clone') do
    repo = Repos.find("#{params[:user]}/#{params[:repo]}")
    repo.clone(Users.find('ys'))
  end
end
