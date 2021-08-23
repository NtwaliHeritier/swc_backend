defmodule SwcBackend.Articles.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :picture, :string
    field :text, :string
    field :video, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:text, :picture, :video])
    |> validate_required([:text, :picture, :video])
  end
end
