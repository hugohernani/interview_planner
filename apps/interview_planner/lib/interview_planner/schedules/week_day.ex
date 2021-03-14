defmodule InterviewPlanner.Schedules.WeekDay do
  defstruct day_name: 'Monday',
            day: 1,
            available_week_hours: [%InterviewPlanner.Schedules.WeekDayHour{}]

  alias Timex.Interval

  def week_days(%{year: p_year, week_number: p_week_number} = week_planner) do
    IO.inspect(week_planner)
    IO.inspect(Timex.from_iso_triplet({p_year, p_week_number, 1}))

    with week_date <- Timex.from_iso_triplet({p_year, p_week_number, 1}),
         first_day_of_week <- Date.beginning_of_week(week_date),
         last_work_day_of_week <- Date.end_of_week(first_day_of_week, :sunday) do
      Interval.new(from: first_day_of_week, until: last_work_day_of_week)
      |> Enum.map(&init_week_day(&1, week_planner))
    end
  end

  defp init_week_day(
         weekday_naive_dt,
         %{start_time: %{hour: start_period}, end_time: %{hour: end_period}, step: p_step}
       ) do
    with week_day = Date.day_of_week(weekday_naive_dt) do
      %__MODULE__{
        day_name: "#{Timex.day_name(week_day)}",
        day: week_day,
        available_week_hours:
          week_day_hours(
            weekday_naive_dt,
            start_period: start_period,
            end_period: end_period,
            interval_period: p_step
          )
      }
    end
  end

  defp week_day_hours(weekday_naive_dt, opts) do
    adjust_interval_step(weekday_naive_dt, opts)
    |> Enum.map(fn naive_date_dt ->
      set_week_day_hour(naive_date_dt)
    end)
  end

  defp adjust_interval_step(weekday_naive_dt, opts) do
    with start_period <- Keyword.get(opts, :start_period, 12),
         end_period <- Keyword.get(opts, :end_period, 20),
         interval_period <- Keyword.get(opts, :interval_period, 30) do
      Interval.new(
        from: %{weekday_naive_dt | hour: start_period, minute: 0, second: 0},
        until: %{weekday_naive_dt | hour: end_period, minute: 0, second: 1}
      )
      |> Interval.with_step(minutes: interval_period)
    end
  end

  defp set_week_day_hour(naive_date_dt, opts \\ []) do
    with available <- Keyword.get(opts, :available_week_hour, true) do
      %InterviewPlanner.Schedules.WeekDayHour{
        naive_date_time: naive_date_dt,
        iso: NaiveDateTime.to_iso8601(naive_date_dt, :basic),
        formatted: Calendar.strftime(naive_date_dt, "%H %M"),
        available: available
      }
    end
  end
end
