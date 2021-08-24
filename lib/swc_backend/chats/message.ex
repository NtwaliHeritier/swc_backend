defmodule SwcBackend.Chats.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias SwcBackend.Accounts.User
  alias SwcBackend.Chats.Room

  schema "messages" do
    field :text, :string
    field :user_id, :id
    field :room_id, :id
    belongs_to :user, User
    belongs_to :room, Room

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end
