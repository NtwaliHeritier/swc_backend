defmodule SwcBackendWeb.Resolvers.InvitationResolvers do
    alias SwcBackend.Friendships

    def list_invitations(_,_,_) do
        invitations = Friendships.list_invitations
        {:ok, invitations}
    end
end