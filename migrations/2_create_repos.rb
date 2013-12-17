Sequel.migration do
  up do
    create_table(:repos) do
      primary_key :id
      String :name
    end
  end

  down do
    drop_table(:repos)
  end
end
