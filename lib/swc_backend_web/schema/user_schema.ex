defmodule SwcBackendWeb.Schema.Types.UserSchema do
    use Absinthe.Schema.Notation

    object :user_type do
        field :id, :id
        field :email, :string
        field :username, :string
    end

    input_object :user_input_type do
        field :email, non_null(:string)
        field :username, non_null(:string)
        field :password, non_null(:string)
        field :password_confirmation, non_null(:string)
    end
end