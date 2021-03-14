defmodule InterviewPlannerWeb.MeetingLive.Index do
  use InterviewPlannerWeb, :live_view

  alias InterviewPlanner.{Planner, Schedules, Schedules.Meeting}

  @impl true
  def mount(_params, _session, socket) do
    Schedules.subscribe()

    curr_datetime = Date.utc_today()

    case Planner.get_week_planner_by_date(curr_datetime) do
      nil ->
        {:ok, assign(socket, week_days: [], meetings: [])}

      %{id: week_planner_id} = week_planner ->
        {:ok,
         socket
         |> assign(meetings: list_meetings(), week_planner_id: week_planner_id)
         |> assign_new(:week_days, fn ->
           Schedules.week_days(week_planner)
         end)}
    end
  end

  @impl true
  def handle_info({Schedules, :selected_hour, week_day_hour}, socket) do
    {
      :noreply,
      socket
      |> assign(:week_planner_id, socket.assigns.week_planner_id)
      |> apply_action(:new, %{
        scheduled_at: week_day_hour.naive_date_time
      })
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Meeting")
    |> assign(:meeting, Schedules.get_meeting!(id))
  end

  defp apply_action(socket, :new, params) do
    socket
    |> assign(:page_title, "New Meeting")
    |> assign(:live_action, :new)
    |> assign(:meeting, Map.merge(%Meeting{}, params))
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Meetings")
    |> assign(:meeting, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    meeting = Schedules.get_meeting!(id)
    {:ok, _} = Schedules.delete_meeting(meeting)

    {:noreply, assign(socket, :meetings, list_meetings())}
  end

  defp list_meetings do
    Schedules.list_meetings()
  end
end
