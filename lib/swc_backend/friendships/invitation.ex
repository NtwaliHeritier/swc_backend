defmodule SwcBackend.Friendships.Invitation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invitations" do
    field :invitee_id, :integer
    field :invitor_id, :integer
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(invitation, attrs) do
    invitation
    |> cast(attrs, [:invitee_id, :invitor_id, :status])
    |> validate_required([:invitee_id, :invitor_id, :status])
  end
end
