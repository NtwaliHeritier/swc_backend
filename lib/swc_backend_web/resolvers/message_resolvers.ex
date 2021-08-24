defmodule SwcBackendWeb.Resolvers.MessageResolvers do
    alias SwcBackend.Chats
    alias SwcBackendWeb.ChangesetErrors

    def create_message(_,%{input: input}, %{context: %{current_user: user}}) do
        input = Map.merge(input, %{user_id: user.id})
        case Chats.create_message(input) do
            {:ok, message} ->
                {:ok, message}
            {:error, %Ecto.Changeset{} = changeset} ->
                {:error, message: "Message not created", details: ChangesetErrors.error_details(changeset)}
        end
    end
end