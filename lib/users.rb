require 'user'

class Users
  def self.find(login)
    user_hash = table[:login => login] || {}
    User.new(user_hash)
  end

  def self.save(user)
    table.insert(user.to_h)
  end

  def self.table
    DB[:users]
  end
end
