defmodule InterviewPlannerWeb.MeetingLive.WeekdayComponent do
  use InterviewPlannerWeb, :live_component

  # alias InterviewPlanner.{WeekDay, WeekDayHour}
  # alias Timex.Interval

  @impl true
  def update(%{week_day: wd}, socket) do
    {:ok, assign(socket, :week_day, wd)}
  end
end
