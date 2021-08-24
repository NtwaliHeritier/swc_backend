defmodule SwcBackendWeb.Schema.Types.InvitationSchema do
    use Absinthe.Schema.Notation
    import Absinthe.Resolution.Helpers, only: [dataloader: 1]

    object :invitation_type do
        field :id, :id
        field :invitor, :user_type, resolve: dataloader(Account)
        field :invitee, :user_type, resolve: dataloader(Account)
    end

    input_object :invitation_input_type do
        field :invitee_id, non_null(:integer)
    end
end