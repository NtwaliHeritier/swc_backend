defmodule SwcBackendWeb.Schema.Types.PostSchema do
    use Absinthe.Schema.Notation

    object :post_type do
        field :id, :id
        field :text, :string
        field :picture, :string
        field :video, :string
    end

    input_object :post_input_type do
        field :text, non_null(:string)
        field :picture, :string
        field :video, :string
    end
end