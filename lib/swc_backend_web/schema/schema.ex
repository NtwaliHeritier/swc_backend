defmodule SwcBackendWeb.Schema.Schema do
    use Absinthe.Schema
    alias SwcBackendWeb.Middleware.Authorize
    alias SwcBackend.{Accounts, Articles, Chats, Friendships}

    alias SwcBackendWeb.Resolvers.{PostResolvers, UserResolvers, SessionResolvers, 
    CommentResolvers, RoomResolvers, MessageResolvers, InvitationResolvers, FriendshipResolvers}

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

        @desc "Lists friends"
        field :friends, list_of(:friend_type) do
            resolve(&FriendshipResolvers.list_friends/3)
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

        @desc "Creates an invitation"
        field :add_invitation, :invitation_type do
            arg(:input, :invitation_input_type)
            resolve(&InvitationResolvers.create_invitation/3)
        end

        @desc "Creates friendship"
        field :add_friend, :friend_type do
            arg(:input, :friend_input_type)
            resolve(&FriendshipResolvers.create_friend/3)
        end
    end

    subscription do
        @desc "Adds realtime to post creation"
        field :subscribe_post, :post_type do
            config fn(_,_) ->
                {:ok, topic: :post_add}
            end
        end

        @desc "Adds realtime to comment creation"
        field :subscribe_comment, :comment_type do
            arg(:post_id, non_null(:id))
            config fn(args,_) ->
                {:ok, topic: args.post_id}
            end
        end

        @desc "Adds realtime to message add"
        field :subscribe_message, :message_type do
            arg(:room_id, non_null(:id))
            config fn(args,_) ->
                {:ok, topic: args.room_id}
            end
        end

        @desc "Adds realtime to room after message add"
        field :subscribe_room, :message_type do
            config fn(_args, _) ->
                {:ok, topic: :room_subscribe}
            end
        end
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