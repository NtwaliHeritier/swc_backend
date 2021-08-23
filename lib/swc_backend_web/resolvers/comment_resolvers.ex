defmodule SwcBackendWeb.Resolvers.CommentResolvers do
    alias SwcBackend.Articles
    alias SwcBackendWeb.ChangesetErrors

    def create_comment(_,%{input: input}, %{context: %{current_user: user}}) do
        input = Map.merge(input, %{user_id: user.id})
        case Articles.create_comment(input) do
            {:ok, comment} ->
                {:ok, comment}
            {:error, %Ecto.Changeset{} = changeset} ->
                {:error, message: "Comment not added", details: ChangesetErrors.error_details(changeset)}
        end
    end
end