defmodule SwcBackendWeb.Resolvers.RoomResolvers do
    alias SwcBackend.Chats
    alias SwcBackendWeb.ChangesetErrors

    def create_room(_,%{counter_part: input},%{context: %{current_user: user}}) do
        with {:ok, room} <- Chats.create_room,
             {:ok, _} <- Chats.create_room_user(%{room_id: room.id, user_id: user.id}),
             {:ok, _} <- Chats.create_room_user(%{room_id: room.id, user_id: input})
        do
            {:ok, room}
        else
            _ ->
            {:error, message: "Room not created"}
        end
    end
end