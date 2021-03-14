defmodule InterviewPlanner.Schedules.Meeting do
  use Ecto.Schema
  import Ecto.Changeset

  alias InterviewPlanner.Planner.WeekPlanner

  schema "meetings" do
    field :notes, :string
    field :scheduled_at, :naive_datetime
    belongs_to :week_planner, WeekPlanner

    timestamps()
  end

  @doc false
  def changeset(meeting, attrs) do
    meeting
    |> cast(attrs, [:scheduled_at, :week_planner_id, :notes])
    |> validate_required([:scheduled_at, :notes])
    |> assoc_constraint(:week_planner)
  end
end
