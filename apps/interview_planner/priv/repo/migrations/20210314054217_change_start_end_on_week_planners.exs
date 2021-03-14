defmodule InterviewPlanner.Repo.Migrations.ChangeStartEndOnWeekPlanners do
  use Ecto.Migration

  def change do
    alter table(:week_planners) do
      modify :start_time, :time
      modify :end_time, :time
    end
  end
end
