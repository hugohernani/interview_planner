defmodule InterviewPlannerWeb.WeekPlannerLive.Show do
  use InterviewPlannerWeb, :live_view

  alias InterviewPlanner.Planner

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:week_planner, Planner.get_week_planner!(id))}
  end

  defp page_title(:show), do: "Show Week planner"
  defp page_title(:edit), do: "Edit Week planner"
end
