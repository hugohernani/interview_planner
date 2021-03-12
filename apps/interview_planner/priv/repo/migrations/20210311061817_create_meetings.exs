defmodule InterviewPlanner.Repo.Migrations.CreateMeetings do
  use Ecto.Migration

  def change do
    create table(:meetings) do
      add :scheduled_at, :naive_datetime
      add :notes, :string

      timestamps()
    end

  end
end
