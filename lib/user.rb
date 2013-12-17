class User
  attr_accessor :id, :login, :oauth_token, :hipchat_username

  def initialize(hash = {})
    hash.each do |k, v|
      send("#{k}=", v)
    end
  end

  def to_h
    hash = { id: id, login: login, hipchat_username: hipchat_username, oauth_token: oauth_token }
    hash.reject { |_, v| v == nil }
  end

  def exists?
    !id.nil?
  end
end
