defmodule InterviewPlannerWeb.WeekPlannerLive.FormComponent do
  use InterviewPlannerWeb, :live_component

  alias InterviewPlanner.Planner

  @impl true
  def update(%{week_planner: week_planner} = assigns, socket) do
    changeset = Planner.change_week_planner(week_planner)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"week_planner" => week_planner_params}, socket) do
    changeset =
      socket.assigns.week_planner
      |> Planner.change_week_planner(week_planner_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"week_planner" => week_planner_params}, socket) do
    save_week_planner(socket, socket.assigns.action, week_planner_params)
  end

  defp save_week_planner(socket, :edit, week_planner_params) do
    case Planner.update_week_planner(socket.assigns.week_planner, week_planner_params) do
      {:ok, _week_planner} ->
        {:noreply,
         socket
         |> put_flash(:info, "Week planner updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_week_planner(socket, :new, week_planner_params) do
    case Planner.create_week_planner(week_planner_params) do
      {:ok, _week_planner} ->
        {:noreply,
         socket
         |> put_flash(:info, "Week planner created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
