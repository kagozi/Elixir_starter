defmodule LiveWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LiveWebWeb.Telemetry,
      # Start the Ecto repository
      LiveWeb.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiveWeb.PubSub},
      # Start Finch
      {Finch, name: LiveWeb.Finch},
      # Start the Endpoint (http/https)
      LiveWebWeb.Endpoint
      # Start a worker by calling: LiveWeb.Worker.start_link(arg)
      # {LiveWeb.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveWebWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
