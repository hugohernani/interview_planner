defmodule InterviewPlanner.Repo.Migrations.AddMonthIntoWeekPlanner do
  use Ecto.Migration

  def change do
    alter table(:week_planners) do
      add :month, :integer
    end
  end
end
