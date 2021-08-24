defmodule SwcBackendWeb.Schema.Types.RoomSchema do
    use Absinthe.Schema.Notation
    import Absinthe.Resolution.Helpers, only: [dataloader: 1]


    object :room_type do
        field :id, :id
        field :messages, :message_type, resolve: dataloader(Chat)
    end
end