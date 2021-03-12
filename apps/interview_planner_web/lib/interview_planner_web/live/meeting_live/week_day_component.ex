defmodule InterviewPlannerWeb.MeetingLive.WeekdayComponent do
  use InterviewPlannerWeb, :live_component

  # alias InterviewPlanner.{WeekDay, WeekDayHour}
  # alias Timex.Interval

  @impl true
  def update(%{week_day: _week_day}, socket) do
    {:ok, socket}
  end
end
