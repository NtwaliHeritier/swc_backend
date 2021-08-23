defmodule SwcBackend.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :text, :string
      add :picture, :string
      add :video, :string

      timestamps()
    end

  end
end
