defmodule InterviewPlanner.Schedules do
  @moduledoc """
  The Schedules context.
  """

  import Ecto.Query, warn: false
  alias InterviewPlanner.Repo

  alias InterviewPlanner.Schedules.Meeting

  @topic inspect(__MODULE__)

  defdelegate week_days(current_date), to: InterviewPlanner.Schedules.WeekDay

  def list_meetings do
    Repo.all(Meeting)
  end

  def get_meeting!(id), do: Repo.get!(Meeting, id)

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

  def subscribe do
    Phoenix.PubSub.subscribe(InterviewPlanner.PubSub, @topic)
  end

  def broadcast_change(event, payload) do
    Phoenix.PubSub.broadcast(InterviewPlanner.PubSub, @topic, {__MODULE__, event, payload})

    {:ok, payload}
  end
end
