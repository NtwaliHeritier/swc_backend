defmodule SwcBackendWeb.Resolvers.UserResolvers do
    alias SwcBackend.Accounts
    alias SwcBackendWeb.ChangesetErrors
    alias SwcBackend.Guardian

    def create_user(_, %{input: %{picture: picture} = input}, _) do
        {:ok, %{url: picture_url}} = Cloudex.upload(picture)
        compute_create(%{input | picture: picture_url})
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