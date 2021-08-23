defmodule SwcBackend.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias SwcBackend.Articles.Post

  schema "users" do
    field :email, :string, unique: true
    field :password_hash, :string
    field :username, :string, unique: true
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :role, :string, default: "user"
    field :names, :string
    field :age, :integer
    field :gender, :integer
    field :phone, :integer
    field :picture, :integer
    field :status, :integer
    has_many :posts, Post

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password, :password_confirmation, :names, :age, :gender, :phone, :picture, :status])
    |> validate_required([:email, :username, :password, :password_confirmation, :names, :age, :gender, :phone, :picture, :status])
    |> update_change(:email, &String.downcase/1)
    |> update_change(:username, &String.downcase/1)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:username)
    |> validate_confirmation(:password)
    |> password_hash()
  end

  defp password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp password_hash(changeset) do
    changeset
  end
end
