defmodule SwcBackendWeb.Schema.Types do
    alias __MODULE__
    use Absinthe.Schema.Notation

    import_types(Types.PostSchema)
    import_types(Types.UserSchema)
    import_types(Types.SessionSchema)
    import_types(Types.CommentSchema)
    import_types(Types.RoomSchema)
    import_types(Types.MessageSchema)
    import_types(Types.InvitationSchema)
end