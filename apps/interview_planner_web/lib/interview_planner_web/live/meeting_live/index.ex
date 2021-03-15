defmodule InterviewPlannerWeb.MeetingLive.Index do
  use InterviewPlannerWeb, :live_view

  alias InterviewPlanner.{Planner, Schedules, Schedules.Meeting}

  alias InterviewPlannerWeb.{
    MeetingLive,
    MeetingLive.Communication,
    MeetingLive.WeekdayHourComponent
  }

  @impl true
  def mount(_params, _session, socket) do
    curr_datetime = Date.utc_today()
    mount_planning(socket, curr_datetime)
  end

  @impl true
  def handle_info({Communication, :selected_hour, week_day_hour}, socket) do
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
  def handle_info({Communication, :update_selected_hour, week_day_hour}, socket) do
    send_update(WeekdayHourComponent, id: week_day_hour.iso_id, week_day_hour: week_day_hour)

    {:noreply, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
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

    {:noreply, assign(socket, :meetings, list_meetings(meeting.week_planner))}
  end

  def planner_heading(%{week_number: week_number, month: month, year: year}) do
    "Available meeting hours for #{week_number}th of #{Timex.month_name(month)}, #{year}"
  end

  def planner_heading(nil), do: "There is no available Schedule for this time"

  defp mount_planning(socket, curr_datetime) do
    case Planner.get_week_planner_by_date(curr_datetime) do
      nil ->
        {:ok, assign(socket, week_days: [], meetings: [], week_planner: nil)}

      %{id: week_planner_id} = week_planner ->
        MeetingLive.subscribe(week_planner_id)

        {:ok,
         socket
         |> assign(meetings: list_meetings(week_planner), week_planner_id: week_planner_id)
         |> assign(:week_planner, week_planner)
         |> assign_new(:week_days, fn ->
           Schedules.week_days(week_planner)
         end)}
    end
  end

  defp list_meetings(week_planner) do
    week_planner.meetings
  end
end
