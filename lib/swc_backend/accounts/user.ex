defmodule SwcBackend.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string, unique: true
    field :password_hash, :string
    field :username, :string, unique: true
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password, :password_confirmation])
    |> validate_required([:email, :username, :password, :password_confirmation])
    |> unique_constraint([:username, :email])
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
