defmodule SwcBackend.Articles.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias SwcBackend.Articles.Post
  alias SwcBackend.Accounts.User

  schema "comments" do
    field :text, :string
    belongs_to :post, Post
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:text, :post_id, :user_id])
    |> validate_required([:text, :post_id, :user_id])
    |> assoc_constraint(:user)
    |> assoc_constraint(:post)
  end
end
