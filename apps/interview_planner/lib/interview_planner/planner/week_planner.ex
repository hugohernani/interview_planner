defmodule InterviewPlanner.Planner.WeekPlanner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "week_planners" do
    field :end_time, :naive_datetime
    field :interval, :integer
    field :start_time, :naive_datetime
    field :step, :integer
    field :week_number, :integer
    field :year, :integer

    timestamps()
  end

  @doc false
  def changeset(week_planner, attrs) do
    week_planner
    |> cast(attrs, [:week_number, :year, :step, :interval, :start_time, :end_time])
    |> validate_required([:week_number, :year, :step, :interval, :start_time, :end_time])
  end
end
