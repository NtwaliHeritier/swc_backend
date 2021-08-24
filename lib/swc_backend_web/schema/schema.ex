defmodule SwcBackendWeb.Schema.Schema do
    use Absinthe.Schema
    alias SwcBackendWeb.Middleware.Authorize
    alias SwcBackend.{Accounts, Articles, Chats, Friendships}

    alias SwcBackendWeb.Resolvers.{PostResolvers, UserResolvers, SessionResolvers, 
    CommentResolvers, RoomResolvers, MessageResolvers, InvitationResolvers}

    import_types(SwcBackendWeb.Schema.Types)

    query do
        @desc "Retrieves all posts"
        field :posts, list_of(:post_type) do
            middleware(Authorize, :any)
            resolve(&PostResolvers.list_posts/3)
        end

        @desc "Retrieves user rooms"
        field :rooms, list_of(:room_user_type) do
            resolve(&RoomResolvers.list_rooms/3)
        end

        @desc "Retrieves invitations"
        field :invitations, list_of(:invitation_type) do
            resolve(&InvitationResolvers.list_invitations/3)
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
            arg(:counter_part, :integer)
            resolve(&RoomResolvers.create_room/3)
        end

        @desc "Creates message"
        field :add_message, :message_type do
            arg(:input, :message_input_type)
            resolve(&MessageResolvers.create_message/3)
        end

        # @desc "Creates an invitation"
        # field :add_invitation do
            
        # end
    end

    def context(ctx) do
        article_datasource = Articles.datasource()
        account_datasource = Accounts.datasource()
        chat_datasource = Chats.datasource()
        friendship_datasource = Friendships.datasource()
        loader = Dataloader.new
                |> Dataloader.add_source(Article, article_datasource)
                |> Dataloader.add_source(Account, account_datasource)
                |> Dataloader.add_source(Chat, chat_datasource)
                |> Dataloader.add_source(Friendship, friendship_datasource)
        Map.put(ctx, :loader, loader)
    end

    def plugins do
        [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults
    end
end