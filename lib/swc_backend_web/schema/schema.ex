defmodule SwcBackendWeb.Schema.Schema do
    use Absinthe.Schema
    alias SwcBackendWeb.Middleware.Authorize
    alias SwcBackend.{Accounts, Articles, Chats}

    alias SwcBackendWeb.Resolvers.{PostResolvers, UserResolvers, SessionResolvers, CommentResolvers}

    import_types(SwcBackendWeb.Schema.Types)

    query do
        @desc "Retrieves all posts"
        field :posts, list_of(:post_type) do
            middleware(Authorize, "user")
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

        @desc "Logs in a user"
        field :login_user, :session_type do
            arg(:input, non_null(:session_input_type))
            resolve(&SessionResolvers.login_user/3)
        end

        @desc "Adds a comment to a post"
        field :add_comment, :comment_type do
            arg(:input, :comment_input_type)
            resolve(&CommentResolvers.create_comment/3)
        end

        @desc "Adds a room"
        field :add_room, :room_type do
            arg(:input, :room_input_type)
        end
    end

    def context(ctx) do
        article_datasource = Articles.datasource()
        account_datasource = Accounts.datasource()
        chat_datasource = Chats.datasource()
        loader = Dataloader.new
                |> Dataloader.add_source(Article, article_datasource)
                |> Dataloader.add_source(Account, account_datasource)
                |> Dataloader.add_source(Chat, chat_datasource)
        Map.put(ctx, :loader, loader)
    end

    def plugins do
        [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults
    end
end