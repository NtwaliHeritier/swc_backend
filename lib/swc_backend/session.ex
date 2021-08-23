defmodule SwcBackend.Session do
    alias SwcBackend.Repo
    alias SwcBackend.Accounts.User

    def authenticate(arg) do
        user = Repo.get_by(User, email: arg.email)
        case check_pass(user, arg) do
           true ->
                {:ok, user}
            false ->
                {:error, :incorrect_credential} 
        end
    end

    defp check_pass(user, arg) do
        case user do
            nil ->
                Argon2.no_user_verify()
            %User{} = user ->
                Argon2.verify_pass(arg.password, user.password_hash)
        end
    end
end