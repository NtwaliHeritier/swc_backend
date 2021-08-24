defmodule SwcBackend.Chats.Room do
  use Ecto.Schema
  import Ecto.Changeset
  alias SwcBackend.Chats.Message
  alias SwcBackend.Chats.RoomUser

  schema "rooms" do
    has_many :messages, Message
    has_many :room_users, RoomUser
    has_many :users, through: [:room_users, :user]
    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [])
    |> validate_required([])
  end
end
