defmodule SwcBackendWeb.Schema.Types do
    alias __MODULE__
    use Absinthe.Schema.Notation

    import_types(Types.PostSchema)
end