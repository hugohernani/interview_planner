defmodule InterviewPlannerWeb.MeetingLive.WeekdayHourComponent do
  use InterviewPlannerWeb, :live_component

  alias InterviewPlanner.{Schedules}

  @impl true
  def update(%{week_day_hour: week_day_hour} = assigns, socket) do
    {
      :ok,
      assign(socket, assigns)
      |> assign(:week_day_hour_id, week_day_hour_id(week_day_hour))
    }
  end

  @impl true
  def handle_event(
        "selected_hour",
        _params,
        %{
          assigns: %{
            week_day_hour: week_day_hour
          }
        } = socket
      ) do
    Schedules.broadcast_change(:selected_hour, week_day_hour)

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
