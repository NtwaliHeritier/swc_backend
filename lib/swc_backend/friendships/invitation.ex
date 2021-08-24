defmodule SwcBackend.Friendships.Invitation do
  use Ecto.Schema
  import Ecto.Changeset
  alias SwcBackend.Accounts.User

  schema "invitations" do
    belongs_to :invitee, User
    belongs_to :invitor, User
    field :status, :string, default: "pending"

    timestamps()
  end

  @doc false
  def changeset(invitation, attrs) do
    invitation
    |> cast(attrs, [:invitee_id, :invitor_id, :status])
    |> validate_required([:invitee_id, :invitor_id, :status])
  end
end
