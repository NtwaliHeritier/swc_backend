defmodule SwcBackendWeb.Schema.Types.SessionSchema do
    use Absinthe.Schema.Notation

    object :session_type do
        field :user, :user_type
        field :token, :string
    end

    input_object :session_input_type do
        field :email, non_null(:string)
        field :password, non_null(:string)
    end
end