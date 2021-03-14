defmodule InterviewPlannerWeb.MeetingLive.WeekdayComponent do
  use InterviewPlannerWeb, :live_component

  @impl true
  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end
end
