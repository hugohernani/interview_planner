defmodule InterviewPlanner.Schedules do
  import Ecto.Query, warn: false
  alias InterviewPlanner.Repo

  alias InterviewPlanner.Schedules.Meeting

  defdelegate week_days(current_date), to: InterviewPlanner.Schedules.WeekDay

  def list_meetings do
    Repo.all(Meeting)
  end

  def get_meeting!(id) do
    Repo.get!(Meeting, id)
    |> Repo.preload(:week_planner)
  end

  def create_meeting(attrs \\ %{}) do
    %Meeting{}
    |> Meeting.changeset(attrs)
    |> Repo.insert()
  end

  def update_meeting(%Meeting{} = meeting, attrs) do
    meeting
    |> Meeting.changeset(attrs)
    |> Repo.update()
  end

  def delete_meeting(%Meeting{} = meeting) do
    Repo.delete(meeting)
  end

  def change_meeting(%Meeting{} = meeting, attrs \\ %{}) do
    Meeting.changeset(meeting, attrs)
  end
end
