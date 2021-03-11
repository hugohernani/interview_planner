defmodule InterviewPlanner.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      InterviewPlanner.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: InterviewPlanner.PubSub}
      # Start a worker by calling: InterviewPlanner.Worker.start_link(arg)
      # {InterviewPlanner.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: InterviewPlanner.Supervisor)
  end
end
