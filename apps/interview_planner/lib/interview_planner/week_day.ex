defmodule InterviewPlanner.WeekDayHour do
  defstruct naive_date_time: nil, formatted: "12:00 AM", available: true, iso: nil
end

defmodule InterviewPlanner.WeekDay do
  defstruct day_name: 'Monday', day: 1, available_week_hours: [%InterviewPlanner.WeekDayHour{}]
end
