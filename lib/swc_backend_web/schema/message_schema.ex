defmodule SwcBackendWeb.Schema.Types.MessageSchema do
    use Absinthe.Schema.Notation
    import Absinthe.Resolution.Helpers, only: [dataloader: 1]
    
    object :message_type do
        field :id, :id
        field :text, :string
        field :user, :user_type, resolve: dataloader(Account)
    end

    input_object :message_input_type do
        field :text, :string
        field :room_id, :integer
    end
end