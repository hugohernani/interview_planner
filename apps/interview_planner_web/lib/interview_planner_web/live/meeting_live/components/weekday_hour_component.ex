defmodule InterviewPlannerWeb.MeetingLive.WeekdayHourComponent do
  use InterviewPlannerWeb, :live_component

  alias InterviewPlannerWeb.MeetingLive

  @impl true
  def update(assigns, socket) do
    {
      :ok,
      assign(socket, assigns)
      |> assign(:style_class, css_style_class(assigns.week_day_hour))
    }
  end

  @impl true
  def handle_event("selected_hour", _params, %{assigns: assigns} = socket) do
    new_week_day_hour = update_week_hour(assigns.week_day_hour)

    MeetingLive.notify_live_view(self(), :selected_hour, new_week_day_hour)

    MeetingLive.broadcast_change_to_others(
      new_week_day_hour.week_planner_id,
      :update_selected_hour,
      new_week_day_hour
    )

    {
      :noreply,
      assign(socket, :week_day_hour, new_week_day_hour)
    }
  end

  defp update_week_hour(curr_week_day_hour) do
    %{
      curr_week_day_hour
      | in_progress: true
    }
  end

  defp css_style_class(%{in_progress: _bool_value = false, available: _available = false}) do
    "unavailable"
  end

  defp css_style_class(%{in_progress: _bool_value = false}) do
    "idle"
  end

  defp css_style_class(%{in_progress: _bool_value = true}) do
    "locked"
  end
end
