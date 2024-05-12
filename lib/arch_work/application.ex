defmodule ArchWork.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ArchWorkWeb.Telemetry,
      ArchWork.Repo,
      {DNSCluster, query: Application.get_env(:arch_work, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ArchWork.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ArchWork.Finch},
      # Start a worker by calling: ArchWork.Worker.start_link(arg)
      # {ArchWork.Worker, arg},
      # Start to serve requests, typically the last entry
      ArchWorkWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ArchWork.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ArchWorkWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
