defmodule SwcBackendWeb.Resolvers.InvitationResolvers do
    alias SwcBackend.Friendships
    alias SwcBackendWeb.ChangesetErrors

    def list_invitations(_,_,_) do
        invitations = Friendships.list_invitations
        {:ok, invitations}
    end

    def create_invitation(_,%{input: input}, %{context: %{current_user: user}}) do
        input = Map.merge(input, %{invitor_id: user.id})
        case Friendships.create_invitation(input) do
            {:ok, user} ->
                {:ok, user}
            {:error, %Ecto.Changeset{} = changeset} ->
                {:error, message: "Invitation not sent", details: ChangesetErrors.error_details(changeset)}
        end
    end
end