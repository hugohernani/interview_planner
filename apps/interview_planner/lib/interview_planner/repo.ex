defmodule InterviewPlanner.Repo do
  use Ecto.Repo,
    otp_app: :interview_planner,
    adapter: Ecto.Adapters.Postgres
end
