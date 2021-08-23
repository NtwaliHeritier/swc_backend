defmodule SwcBackendWeb.Schema.Schema do
    use Absinthe.Schema

    alias SwcBackendWeb.Resolvers.PostResolvers

    import_types(SwcBackendWeb.Schema.Types)

    query do
        @desc "Retrieves all posts"
        field :posts, list_of(:post_type) do
            resolve(&PostResolvers.list_posts/3)
        end
    end

    mutation do
        @desc "Saves a post"
        field :create_post, :post_type do
            arg(:input, non_null(:post_input_type))
            resolve(&PostResolvers.create_post/3)
        end
    end
end