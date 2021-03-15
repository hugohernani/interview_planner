defmodule InterviewPlannerWeb.MeetingLive.Communication do
  @topic inspect(__MODULE__)

  def subscribe(week_planner_id) do
    Phoenix.PubSub.subscribe(InterviewPlanner.PubSub, week_planner_topic(week_planner_id))
  end

  def broadcast_change_to_others(week_planner_id, event, payload) do
    Phoenix.PubSub.broadcast_from(
      InterviewPlanner.PubSub,
      self(),
      week_planner_topic(week_planner_id),
      {__MODULE__, event, payload}
    )

    {:ok, payload}
  end

  def notify_live_view(server_pid, event, payload) do
    send(server_pid, {__MODULE__, event, payload})
  end

  defp week_planner_topic(wp_id) do
    "#{@topic}-#{wp_id}"
  end
end
