defmodule InterviewPlannerWeb.MeetingLive.WeekListingComponent do
  use InterviewPlannerWeb, :live_component

  alias InterviewPlanner.{WeekDay, WeekDayHour}
  alias Timex.Interval

  @impl true
  def update(_assigns, socket) do
    {:ok,
     socket
     |> assign(:available_week_days, available_week_days())}
  end

  defp available_week_days do
    with current_date <- Date.utc_today(),
         first_day_of_week <- Date.beginning_of_week(current_date),
         last_work_day_of_week <- Date.end_of_week(current_date, :saturday) do
      Interval.new(from: first_day_of_week, until: last_work_day_of_week)
      |> Enum.map(&init_week_day/1)
    end
  end

  defp init_week_day(weekday_naive_dt) do
    with week_day = Date.day_of_week(weekday_naive_dt) do
      %WeekDay{
        day_name: "#{Timex.day_name(week_day)}",
        day: week_day,
        available_week_hours: week_day_hours(weekday_naive_dt)
      }
    end
  end

  defp week_day_hours(weekday_naive_dt, opts \\ %{}) do
    adjust_interval_step(weekday_naive_dt, opts)
    |> Enum.map(fn naive_date_dt ->
      init_week_hour(naive_date_dt)
    end)
  end

  defp adjust_interval_step(weekday_naive_dt, opts) do
    with start_period <- Map.get(opts, :start_period, 12),
         end_period <- Map.get(opts, :end_period, 20),
         interval_period <- Map.get(opts, :interval_period, 30) do
      Interval.new(
        from: %{weekday_naive_dt | hour: start_period, minute: 0, second: 0},
        until: %{weekday_naive_dt | hour: end_period, minute: 0, second: 1}
      )
      |> Interval.with_step(minutes: interval_period)
    end
  end

  defp init_week_hour(naive_date_dt, opts \\ %{}) do
    with available <- Map.get(opts, :available_week_hour, true) do
      %WeekDayHour{
        naive_date_time: naive_date_dt,
        iso: NaiveDateTime.to_iso8601(naive_date_dt, :basic),
        formatted: Calendar.strftime(naive_date_dt, "%H %M"),
        available: available
      }
    end
  end
end
