defmodule LivekitCourse.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LivekitCourseWeb.Telemetry,
      LivekitCourse.Repo,
      {DNSCluster, query: Application.get_env(:livekit_course, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LivekitCourse.PubSub},
      # Start a worker by calling: LivekitCourse.Worker.start_link(arg)
      # {LivekitCourse.Worker, arg},
      # Start to serve requests, typically the last entry
      LivekitCourseWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LivekitCourse.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LivekitCourseWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
