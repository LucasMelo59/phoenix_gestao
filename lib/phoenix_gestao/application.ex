defmodule PhoenixGestao.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixGestaoWeb.Telemetry,
      PhoenixGestao.Repo,
      {DNSCluster, query: Application.get_env(:phoenix_gestao, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhoenixGestao.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhoenixGestao.Finch},
      # Start a worker by calling: PhoenixGestao.Worker.start_link(arg)
      # {PhoenixGestao.Worker, arg},
      # Start to serve requests, typically the last entry
      PhoenixGestaoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixGestao.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixGestaoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
