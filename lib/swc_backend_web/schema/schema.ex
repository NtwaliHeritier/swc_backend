defmodule SwcBackendWeb.Schema.Schema do
    use Absinthe.Schema
    alias SwcBackendWeb.Middleware.Authorize

    alias SwcBackendWeb.Resolvers.{PostResolvers, UserResolvers, SessionResolvers}

    import_types(SwcBackendWeb.Schema.Types)

    query do
        @desc "Retrieves all posts"
        field :posts, list_of(:post_type) do
            # middleware(Authorize, "user")
            resolve(&PostResolvers.list_posts/3)
        end
    end

    mutation do
        @desc "Saves a post"
        field :create_post, :post_type do
            arg(:input, non_null(:post_input_type))
            resolve(&PostResolvers.create_post/3)
        end

        @desc "Saves a user"
        field :create_user, :session_type do
            arg(:input, non_null(:user_input_type))
            resolve(&UserResolvers.create_user/3)
        end

        @desc "login user"
        field :login_user, :session_type do
            arg(:input, non_null(:session_input_type))
            resolve(&SessionResolvers.login_user/3)
        end
    end
end