defmodule SwcBackend.Friendships.Friend do
  use Ecto.Schema
  import Ecto.Changeset
  alias SwcBackend.Accounts.User

  schema "friends" do
    belongs_to :followee, User
    belongs_to :follower, User

    timestamps()
  end

  @doc false
  def changeset(friend, attrs) do
    friend
    |> cast(attrs, [:follower_id, :followee_id])
    |> validate_required([:follower_id, :followee_id])
  end
end
