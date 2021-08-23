defmodule SwcBackend.Repo.Migrations.AlterUserGender do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :gender, :string
      modify :picture, :string
    end

    create unique_index(:users, [:email])
  end
end
