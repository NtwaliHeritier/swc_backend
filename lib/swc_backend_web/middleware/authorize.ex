defmodule SwcBackendWeb.Middleware.Authorize do
    @behaviour Absinthe.Middleware

    def call(resolution, role) do
        with %{current_user: user} <- resolution.context,
             true <- verify_role(user, role)
        do
            resolution
        else
            _ ->
                resolution
                |> Absinthe.Resolution.put_result({:error, :not_authorized})
        end
    end

    defp verify_role(_, :any), do: true
    defp verify_role(%{role: role}, role), do: true
    defp verify_role(_,_), do: false
end