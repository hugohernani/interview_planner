defmodule InterviewPlannerWeb.WeekPlannerLive.Index do
  use InterviewPlannerWeb, :live_view

  alias InterviewPlanner.Planner
  alias InterviewPlanner.Planner.WeekPlanner

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :week_planners, list_week_planners())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Week planner")
    |> assign(:week_planner, Planner.get_week_planner!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Week planner")
    |> assign(:week_planner, Planner.default_week_planner(Date.utc_today()))
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Week planners")
    |> assign(:week_planner, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    week_planner = Planner.get_week_planner!(id)
    {:ok, _} = Planner.delete_week_planner(week_planner)

    {:noreply, assign(socket, :week_planners, list_week_planners())}
  end

  defp list_week_planners do
    Planner.list_week_planners()
  end
end
