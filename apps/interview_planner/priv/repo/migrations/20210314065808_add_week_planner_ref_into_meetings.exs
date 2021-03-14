defmodule InterviewPlanner.Repo.Migrations.AddWeekPlannerRefIntoMeetings do
  use Ecto.Migration

  def change do
    alter table(:meetings) do
      add :week_planner_id, references(:week_planners)
    end

    create index(:meetings, [:week_planner_id])
  end
end
