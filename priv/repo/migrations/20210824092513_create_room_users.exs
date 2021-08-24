defmodule SwcBackend.Repo.Migrations.CreateRoomUsers do
  use Ecto.Migration

  def change do
    create table(:room_users) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :room_id, references(:rooms, on_delete: :delete_all)

      timestamps()
    end

    create index(:room_users, [:user_id])
    create index(:room_users, [:room_id])
  end
end
