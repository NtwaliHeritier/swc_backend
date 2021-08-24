defmodule SwcBackend.Chats.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias SwcBackend.Accounts.User
  alias SwcBackend.Chats.Room

  schema "messages" do
    field :text, :string
    belongs_to :user, User
    belongs_to :room, Room

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:text])
    |> validate_required([:text])
    |> assoc_constraint(:user)
    |> assoc_constraint(:room)
  end
end
