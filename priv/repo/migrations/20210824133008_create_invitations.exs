defmodule SwcBackend.Repo.Migrations.CreateInvitations do
  use Ecto.Migration

  def change do
    create table(:invitations) do
      add :invitee_id, :integer
      add :invitor_id, :integer
      add :status, :string

      timestamps()
    end

    create index(:invitations, [:invitee_id, :invitor_id])
  end
end
