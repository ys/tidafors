require 'fileutils'
require 'git'

class Repo
  attr_accessor :id, :name

  def initialize(hash = {})
    hash.each do |k, v|
      send("#{k}=", v)
    end
  end

  def to_h
    hash = { id: id, name: name }
    hash.reject { |_, v| v == nil }
  end

  def url(user)
    "https://#{user.oauth_token}@github.com/#{name}.git"
  end

  def clone(user)
    Git.clone(url(user), "./tmp/checkout/#{name}")
  end
end
