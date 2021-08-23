defmodule SwcBackendWeb.Resolvers.UserResolvers do
    alias SwcBackend.Accounts
    alias SwcBackendWeb.ChangesetErrors

    def create_user(_,%{input: input},_) do
        case Accounts.create_user(input) do
            {:ok, user} ->
                {:ok, user}
            {:error, %Ecto.Changeset{} = changeset} ->
                {:error, message: "User not created", details: ChangesetErrors.error_details(changeset)}
        end
    end
end