defmodule SwcBackend.Chats.Room do
  use Ecto.Schema
  import Ecto.Changeset
  alias SwcBackend.Chats.Message

  schema "rooms" do
    has_many :messages, Message
    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [])
    |> validate_required([])
  end
end
