defmodule SwcBackendWeb.Schema.Types.PostSchema do
    use Absinthe.Schema.Notation
    import Absinthe.Resolution.Helpers, only: [dataloader: 1]

    object :post_type do
        field :id, :id
        field :text, :string
        field :picture, :string
        field :video, :string
        field :user, :user_type, resolve: dataloader(Account)
        field :comments, list_of(:comment_type), resolve: dataloader(Article)
    end

    input_object :post_input_type do
        field :text, non_null(:string)
        field :picture, :string
        field :video, :string
    end
end