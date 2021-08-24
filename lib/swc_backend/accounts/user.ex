defmodule SwcBackend.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias SwcBackend.Articles.{Post, Comment}
  alias SwcBackend.Chats.RoomUser
  alias SwcBackend.Friendships.Invitation
  alias SwcBackend.Friendships.Friend

  schema "users" do
    field :email, :string, unique: true
    field :password_hash, :string
    field :username, :string, unique: true
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :role, :string, default: "user"
    field :names, :string
    field :age, :integer
    field :gender, :string
    field :phone, :string
    field :picture, :string, default: "none"
    field :status, :string
    has_many :posts, Post
    has_many :comments, Comment
    has_many :room_users, RoomUser
    has_many :rooms, through: [:room_users, :room]
    has_many :received_invitations, Invitation, foreign_key: :invitee_id
    has_many :invitors, through: [:received_invitations, :invitor]
    has_many :sent_invitations, Invitation, foreign_key: :invitor_id
    has_many :invitees, through: [:sent_invitations, :invitee]
    has_many :follower_friends, Friend, foreign_key: :follower_id
    has_many :followees, through: [:follower_friends, :followee]
    has_many :followee_friends, Friend, foreign_key: :followee_id
    has_many :followers, through: [:followee_friends, :follower]

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password, :password_confirmation, :names, :age, :gender, :phone, :picture, :status])
    |> validate_required([:email, :username, :password, :password_confirmation, :names, :age, :gender, :phone, :status])
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
