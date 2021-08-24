defmodule SwcBackend.Chats.RoomUser do
  use Ecto.Schema
  import Ecto.Changeset
  alias SwcBackend.Accounts.User
  alias SwcBackend.Chats.Room

  schema "room_users" do
    belongs_to :user, User
    belongs_to :room, Room

    timestamps()
  end

  @doc false
  def changeset(room_user, attrs) do
    room_user
    |> cast(attrs, [:room_id, :user_id])
    |> validate_required([:room_id, :user_id])
  end
end
