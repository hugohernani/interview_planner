defmodule InterviewPlannerWeb.MeetingLive.WeekdayHourComponent do
  use InterviewPlannerWeb, :live_component

  # alias InterviewPlanner.{WeekDay, WeekDayHour}
  # alias Timex.Interval

  @impl true
  def update(%{week_day: week_day, week_day_hour: week_day_hour}, socket) do
    {
      :ok,
      assign(socket, :week_day_hour, week_day_hour)
      |> assign(:week_day, week_day)
      |> assign(:week_day_hour_id, week_day_hour_id(week_day_hour))
    }
  end

  @impl true
  def handle_event(
        "selected_hour",
        _params,
        %{assigns: %{week_day_hour: week_day_hour}} = socket
      ) do
    {
      :noreply,
      assign(socket, :week_day_hour, update_week_hour(week_day_hour))
    }
  end

  defp update_week_hour(curr_week_day_hour) do
    %{
      curr_week_day_hour
      | available: false
    }
  end

  defp week_day_hour_id(%{iso: iso}) do
    "iso_#{iso}"
  end
end
