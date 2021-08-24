defmodule SwcBackend.Articles.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias SwcBackend.Accounts.User
  alias SwcBackend.Articles.Comment

  schema "posts" do
    field :picture, :string
    field :text, :string
    field :video, :string
    belongs_to :user, User
    has_many :comments, Comment

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:text, :picture, :video, :user_id])
    |> validate_required([:text])
    |> assoc_constraint(:user)
  end
end
