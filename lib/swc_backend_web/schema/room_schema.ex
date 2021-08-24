defmodule SwcBackendWeb.Schema.Types.RoomSchema do
    use Absinthe.Schema.Notation
    import Absinthe.Resolution.Helpers, only: [dataloader: 1]


    object :room_type do
        field :id, :id
        field :messages, list_of(:message_type), resolve: dataloader(Chat)
        field :users, list_of(:user_type), resolve: dataloader(Account)
    end

    object :room_user_type do
        field :id, :id
        field :room, :room_type, resolve: dataloader(Chat)
    end
end