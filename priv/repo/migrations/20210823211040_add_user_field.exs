defmodule SwcBackend.Repo.Migrations.AddUserField do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :names, :string, null: false
      add :age, :integer, null: false
      add :gender, :integer, null: false
      add :phone, :string, null: false
      add :picture, :string, null: false
      add :status, :string, null: false
    end
  end
end
