defmodule InterviewPlannerWeb.MeetingLive do
  alias InterviewPlannerWeb.MeetingLive.Communication

  defdelegate subscribe(week_planner_id), to: Communication
  defdelegate broadcast_change_to_others(week_planner_id, event, payload), to: Communication
  defdelegate notify_live_view(server_pid, event, payload), to: Communication
end
