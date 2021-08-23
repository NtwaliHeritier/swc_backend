defmodule SwcBackend.Articles.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias SwcBackend.Accounts.User

  schema "posts" do
    field :picture, :string
    field :text, :string
    field :video, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:text, :picture, :video, :user_id])
    |> validate_required([:text])
  end
end
