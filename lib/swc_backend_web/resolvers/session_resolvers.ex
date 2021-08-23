defmodule SwcBackendWeb.Resolvers.SessionResolvers do

    alias SwcBackend.Session
    alias SwcBackend.Guardian 

    def login_user(_,%{input: input}, _) do
        with {:ok, user} <- Session.authenticate(input),
             {:ok, token, _} <- Guardian.encode_and_sign(user) 
        do
            {:ok, %{user: user, token: token}}            
        else
             _ ->
            {:error, message: "Incorrect credentials"}
        end
    end
end