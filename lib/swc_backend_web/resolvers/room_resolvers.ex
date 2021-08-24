defmodule SwcBackendWeb.Resolvers.RoomResolvers do
    alias SwcBackend.Chats

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

    def list_rooms(_,_,%{context: %{current_user: user}}) do
        rooms = Chats.list_room_users_by_user_id(user.id)
        {:ok, rooms}
    end
end