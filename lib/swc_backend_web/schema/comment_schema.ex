defmodule SwcBackendWeb.Schema.Types.CommentSchema do
    use Absinthe.Schema.Notation
    import Absinthe.Resolution.Helpers, only: [dataloader: 1]

    object :comment_type do
        field :id, :id
        field :text, :string
        field :user, :user_type, resolve: dataloader(Account)
    end

    input_object :comment_input_type do
        field :text, non_null(:string)
        field :post_id, non_null(:integer)
    end
end