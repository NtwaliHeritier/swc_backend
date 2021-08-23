defmodule SwcBackendWeb.Context.Context do
    import Plug.Conn
    alias SwcBackend.Guardian

    def init(opts) do
        opts
    end

    def call(conn, _) do
        current_user = build_context(conn)
        Absinthe.Plug.put_options(conn, context: current_user)
    end

    defp build_context(conn) do
        with ["Authorization " <> token] <- get_req_header(conn),
             {:ok, claims} <- Guardian.resource_from_claims(claims),
             {:ok, user} <- Guardian.decode_and_verify(claims)
        do
            %{current_user: user}
        else
            _->
                %{}
        end
    end
end