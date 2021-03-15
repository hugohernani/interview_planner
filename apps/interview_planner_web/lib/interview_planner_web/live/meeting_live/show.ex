defmodule InterviewPlannerWeb.MeetingLive.Show do
  use InterviewPlannerWeb, :live_view

  alias InterviewPlanner.Schedules

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:meeting, Schedules.get_meeting!(id))}
  end

  defp page_title(:show), do: "Show Meeting"
end
