Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id
      String :login
      String :hipchat_username
      String :oauth_token
    end
  end

  down do
    drop_table(:users)
  end
end
