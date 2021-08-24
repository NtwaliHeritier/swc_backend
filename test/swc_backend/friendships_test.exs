defmodule SwcBackend.FriendshipsTest do
  use SwcBackend.DataCase

  alias SwcBackend.Friendships

  describe "invitations" do
    alias SwcBackend.Friendships.Invitation

    @valid_attrs %{invitee_id: 42, invitor_id: 42, status: "some status"}
    @update_attrs %{invitee_id: 43, invitor_id: 43, status: "some updated status"}
    @invalid_attrs %{invitee_id: nil, invitor_id: nil, status: nil}

    def invitation_fixture(attrs \\ %{}) do
      {:ok, invitation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Friendships.create_invitation()

      invitation
    end

    test "list_invitations/0 returns all invitations" do
      invitation = invitation_fixture()
      assert Friendships.list_invitations() == [invitation]
    end

    test "get_invitation!/1 returns the invitation with given id" do
      invitation = invitation_fixture()
      assert Friendships.get_invitation!(invitation.id) == invitation
    end

    test "create_invitation/1 with valid data creates a invitation" do
      assert {:ok, %Invitation{} = invitation} = Friendships.create_invitation(@valid_attrs)
      assert invitation.invitee_id == 42
      assert invitation.invitor_id == 42
      assert invitation.status == "some status"
    end

    test "create_invitation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Friendships.create_invitation(@invalid_attrs)
    end

    test "update_invitation/2 with valid data updates the invitation" do
      invitation = invitation_fixture()
      assert {:ok, %Invitation{} = invitation} = Friendships.update_invitation(invitation, @update_attrs)
      assert invitation.invitee_id == 43
      assert invitation.invitor_id == 43
      assert invitation.status == "some updated status"
    end

    test "update_invitation/2 with invalid data returns error changeset" do
      invitation = invitation_fixture()
      assert {:error, %Ecto.Changeset{}} = Friendships.update_invitation(invitation, @invalid_attrs)
      assert invitation == Friendships.get_invitation!(invitation.id)
    end

    test "delete_invitation/1 deletes the invitation" do
      invitation = invitation_fixture()
      assert {:ok, %Invitation{}} = Friendships.delete_invitation(invitation)
      assert_raise Ecto.NoResultsError, fn -> Friendships.get_invitation!(invitation.id) end
    end

    test "change_invitation/1 returns a invitation changeset" do
      invitation = invitation_fixture()
      assert %Ecto.Changeset{} = Friendships.change_invitation(invitation)
    end
  end

  describe "friends" do
    alias SwcBackend.Friendships.Friend

    @valid_attrs %{followee_id: 42, follower_id: 42}
    @update_attrs %{followee_id: 43, follower_id: 43}
    @invalid_attrs %{followee_id: nil, follower_id: nil}

    def friend_fixture(attrs \\ %{}) do
      {:ok, friend} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Friendships.create_friend()

      friend
    end

    test "list_friends/0 returns all friends" do
      friend = friend_fixture()
      assert Friendships.list_friends() == [friend]
    end

    test "get_friend!/1 returns the friend with given id" do
      friend = friend_fixture()
      assert Friendships.get_friend!(friend.id) == friend
    end

    test "create_friend/1 with valid data creates a friend" do
      assert {:ok, %Friend{} = friend} = Friendships.create_friend(@valid_attrs)
      assert friend.followee_id == 42
      assert friend.follower_id == 42
    end

    test "create_friend/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Friendships.create_friend(@invalid_attrs)
    end

    test "update_friend/2 with valid data updates the friend" do
      friend = friend_fixture()
      assert {:ok, %Friend{} = friend} = Friendships.update_friend(friend, @update_attrs)
      assert friend.followee_id == 43
      assert friend.follower_id == 43
    end

    test "update_friend/2 with invalid data returns error changeset" do
      friend = friend_fixture()
      assert {:error, %Ecto.Changeset{}} = Friendships.update_friend(friend, @invalid_attrs)
      assert friend == Friendships.get_friend!(friend.id)
    end

    test "delete_friend/1 deletes the friend" do
      friend = friend_fixture()
      assert {:ok, %Friend{}} = Friendships.delete_friend(friend)
      assert_raise Ecto.NoResultsError, fn -> Friendships.get_friend!(friend.id) end
    end

    test "change_friend/1 returns a friend changeset" do
      friend = friend_fixture()
      assert %Ecto.Changeset{} = Friendships.change_friend(friend)
    end
  end
end
