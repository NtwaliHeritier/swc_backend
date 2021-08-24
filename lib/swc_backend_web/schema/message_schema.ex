defmodule SwcBackendWeb.Schema.Types.MessageSchema do
    use Absinthe.Schema.Notation
    import Absinthe.Resolution.Helpers, only: [dataloader: 1]
    
    object :message_type do
        field :id, :id
        field :text, :string
        field :user, :user_type, resolve: dataloader(Account)
    end

    input_object :message_input_type do
        field :text, non_null(:string)
        field :room_id, non_null(:integer)
    end
end