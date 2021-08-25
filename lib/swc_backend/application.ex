defmodule SwcBackend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      SwcBackend.Repo,
      # Start the Telemetry supervisor
      SwcBackendWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SwcBackend.PubSub},
      # Start the Endpoint (http/https)
      SwcBackendWeb.Endpoint,
      # Start a worker by calling: SwcBackend.Worker.start_link(arg)
      # {SwcBackend.Worker, arg}
      {Absinthe.Subscription, [SwcBackendWeb.Endpoint]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SwcBackend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SwcBackendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
