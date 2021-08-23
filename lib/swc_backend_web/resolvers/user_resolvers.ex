defmodule SwcBackendWeb.Resolvers.UserResolvers do
    alias SwcBackend.Accounts
    alias SwcBackendWeb.ChangesetErrors
    alias SwcBackend.Guardian

    def create_user(_, %{input: %{picture: picture} = input}, _) do
        with {:ok, picture} <- Cloudex.upload(picture)
        do
            compute_create(%{input | picture: picture.url})
        else
            _ ->
                {:error, message: "Add correct image"}
        end
    end

    def create_user(_,%{input: input},_) do
       compute_create(input) 
    end

    defp compute_create(input) do
        case Accounts.create_user(input) do
            {:ok, user} ->
                {:ok, token, _} = Guardian.encode_and_sign(user)
                {:ok, %{user: user, token: token}}
            {:error, %Ecto.Changeset{} = changeset} ->
                {:error, message: "User not created", details: ChangesetErrors.error_details(changeset)}
        end
    end
end