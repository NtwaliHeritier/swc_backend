defmodule SwcBackendWeb.Schema.Types do
    alias __MODULE__
    use Absinthe.Schema.Notation

    import_types(Types.PostSchema)
    import_types(Types.UserSchema)
    import_types(Types.SessionSchema)
    import_types(Types.CommentSchema)
end