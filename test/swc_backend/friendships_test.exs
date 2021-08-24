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
end
