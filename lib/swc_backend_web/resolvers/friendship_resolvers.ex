defmodule SwcBackendWeb.Resolvers.FriendshipResolvers do
    alias SwcBackend.Friendships
    alias SwcBackendWeb.ChangesetErrors

    def list_friends(_,_,%{context: %{current_user: user}}) do
        friends = Friendships.list_followers(user.id)
        {:ok, friends}
    end

    def create_friend(_,%{input: input},%{context: %{current_user: user}}) do
        input = Map.merge(input, %{followee_id: user.id})
        case Friendships.create_friend(input) do
            {:ok, friend} ->
                spawn(fn -> Friendships.create_friend(%{followee_id: input.follower_id, follower_id: user.id}) end)
                {:ok, friend}
            {:error, %Ecto.Changeset{} = changeset} ->
                {:error, message: "Friend not added", details: ChangesetErrors.error_details(changeset)}
        end
    end
end