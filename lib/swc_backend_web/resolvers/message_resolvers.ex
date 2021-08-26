defmodule SwcBackendWeb.Resolvers.MessageResolvers do
    alias SwcBackend.Chats
    alias SwcBackendWeb.ChangesetErrors

    def create_message(_,%{input: input}, %{context: %{current_user: user}}) do
        input = Map.merge(input, %{user_id: user.id})
        case Chats.create_message(input) do
            {:ok, message} ->
                subscribe(message)
                subscribe_room(message)
                {:ok, message}
            {:error, %Ecto.Changeset{} = changeset} ->
                {:error, message: "Message not created", details: ChangesetErrors.error_details(changeset)}
        end
    end

    defp subscribe(message) do
        Absinthe.Subscription.publish(
            SwcBackendWeb.Endpoint,
            message,
            subscribe_message: message.room_id
        )
    end

    defp subscribe_room(message) do
        Absinthe.Subscription.publish(
            SwcBackendWeb.Endpoint,
            message,
            subscribe_room: :room_subscribe
        )
    end
end