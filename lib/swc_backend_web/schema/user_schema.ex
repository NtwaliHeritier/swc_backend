defmodule SwcBackendWeb.Schema.Types.UserSchema do
    use Absinthe.Schema.Notation

    object :user_type do
        field :id, :id
        field :names, :string
        field :age, :integer
        field :gender, :string
        field :email, :string
        field :username, :string
        field :phone, :string
        field :picture, :string
        field :status, :string
    end

    input_object :user_input_type do
        field :names, non_null(:string)
        field :age,  non_null(:integer)
        field :gender, non_null(:string)
        field :email, non_null(:string)
        field :username, non_null(:string)
        field :password, non_null(:string)
        field :password_confirmation, non_null(:string)
        field :phone,  non_null(:string)
        field :picture,  non_null(:string)
        field :status,  non_null(:string)
    end
end