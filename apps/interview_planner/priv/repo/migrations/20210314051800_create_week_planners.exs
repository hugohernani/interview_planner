defmodule InterviewPlanner.Repo.Migrations.CreateWeekPlanners do
  use Ecto.Migration

  def change do
    create table(:week_planners) do
      add :week_number, :integer
      add :year, :integer
      add :step, :integer
      add :interval, :integer
      add :start_time, :naive_datetime
      add :end_time, :naive_datetime

      timestamps()
    end

  end
end
