defmodule ArchWorkSona.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ArchWorkSonaWeb.Telemetry,
      ArchWorkSona.Repo,
      {DNSCluster, query: Application.get_env(:arch_work_sona, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ArchWorkSona.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ArchWorkSona.Finch},
      # Start a worker by calling: ArchWorkSona.Worker.start_link(arg)
      # {ArchWorkSona.Worker, arg},
      # Start to serve requests, typically the last entry
      ArchWorkSonaWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ArchWorkSona.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ArchWorkSonaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
