defmodule InterviewPlanner.SchedulesTest do
  use InterviewPlanner.DataCase

  alias InterviewPlanner.Schedules

  describe "meetings" do
    alias InterviewPlanner.Schedules.Meeting

    @valid_attrs %{notes: "some notes", scheduled_at: ~N[2010-04-17 14:00:00]}
    @update_attrs %{notes: "some updated notes", scheduled_at: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{notes: nil, scheduled_at: nil}

    def meeting_fixture(attrs \\ %{}) do
      {:ok, meeting} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schedules.create_meeting()

      meeting
    end

    test "list_meetings/0 returns all meetings" do
      meeting = meeting_fixture()
      assert Schedules.list_meetings() == [meeting]
    end

    test "get_meeting!/1 returns the meeting with given id" do
      meeting = meeting_fixture()
      assert Schedules.get_meeting!(meeting.id) == meeting
    end

    test "create_meeting/1 with valid data creates a meeting" do
      assert {:ok, %Meeting{} = meeting} = Schedules.create_meeting(@valid_attrs)
      assert meeting.notes == "some notes"
      assert meeting.scheduled_at == ~N[2010-04-17 14:00:00]
    end

    test "create_meeting/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedules.create_meeting(@invalid_attrs)
    end

    test "update_meeting/2 with valid data updates the meeting" do
      meeting = meeting_fixture()
      assert {:ok, %Meeting{} = meeting} = Schedules.update_meeting(meeting, @update_attrs)
      assert meeting.notes == "some updated notes"
      assert meeting.scheduled_at == ~N[2011-05-18 15:01:01]
    end

    test "update_meeting/2 with invalid data returns error changeset" do
      meeting = meeting_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedules.update_meeting(meeting, @invalid_attrs)
      assert meeting == Schedules.get_meeting!(meeting.id)
    end

    test "delete_meeting/1 deletes the meeting" do
      meeting = meeting_fixture()
      assert {:ok, %Meeting{}} = Schedules.delete_meeting(meeting)
      assert_raise Ecto.NoResultsError, fn -> Schedules.get_meeting!(meeting.id) end
    end

    test "change_meeting/1 returns a meeting changeset" do
      meeting = meeting_fixture()
      assert %Ecto.Changeset{} = Schedules.change_meeting(meeting)
    end
  end
end
