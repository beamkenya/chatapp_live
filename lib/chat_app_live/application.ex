defmodule ChatAppLive.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ChatAppLiveWeb.Telemetry,
      # Start the Ecto repository
      ChatAppLive.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ChatAppLive.PubSub},
      # Start Finch
      {Finch, name: ChatAppLive.Finch},
      # Start the Endpoint (http/https)
      ChatAppLiveWeb.Endpoint
      # Start a worker by calling: ChatAppLive.Worker.start_link(arg)
      # {ChatAppLive.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ChatAppLive.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ChatAppLiveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
