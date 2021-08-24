defmodule SwcBackendWeb.Schema.Types.FriendSchema do
    use Absinthe.Schema.Notation
    import Absinthe.Resolution.Helpers, only: [dataloader: 1]

    object :friend_type do
        field :id, :id
        field :follower, :user_type, resolve: dataloader(Account)
    end

    input_object :friend_input_type do
        field :follower_id, non_null(:integer)
    end
end