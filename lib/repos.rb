require 'repo'

class Repos
  def self.find(name)
    repo_hash = table[:name => name] || {}
    Repo.new(repo_hash)
  end

  def self.save(repo)
    table.insert(repo.to_h)
  end

  def self.table
    DB[:repos]
  end
end
