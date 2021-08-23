defmodule SwcBackendWeb.Resolvers.UserResolvers do
    alias SwcBackend.Accounts
    alias SwcBackendWeb.ChangesetErrors
    alias SwcBackend.Guardian

    def create_user(_,%{input: input},_) do
        case Accounts.create_user(input) do
            {:ok, user} ->
                {:ok, token, _} = Guardian.encode_and_sign(user)
                {:ok, %{user: user, token: token}}
            {:error, %Ecto.Changeset{} = changeset} ->
                {:error, message: "User not created", details: ChangesetErrors.error_details(changeset)}
        end
    end
end