defmodule SwcBackend.Repo.Migrations.AddRoleToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :role, :string
      remove :username, :string
      remove :email, :string
      add :username, :string, unique: true
      add :email, :string, unique: true 
    end
  end
end
