defmodule InterviewPlannerWeb.WeekPlannerLiveTest do
  use InterviewPlannerWeb.ConnCase

  import Phoenix.LiveViewTest

  alias InterviewPlanner.Planner

  @create_attrs %{end_time: ~N[2010-04-17 14:00:00], interval: 42, start_time: ~N[2010-04-17 14:00:00], step: 42, week_number: 42, year: 42}
  @update_attrs %{end_time: ~N[2011-05-18 15:01:01], interval: 43, start_time: ~N[2011-05-18 15:01:01], step: 43, week_number: 43, year: 43}
  @invalid_attrs %{end_time: nil, interval: nil, start_time: nil, step: nil, week_number: nil, year: nil}

  defp fixture(:week_planner) do
    {:ok, week_planner} = Planner.create_week_planner(@create_attrs)
    week_planner
  end

  defp create_week_planner(_) do
    week_planner = fixture(:week_planner)
    %{week_planner: week_planner}
  end

  describe "Index" do
    setup [:create_week_planner]

    test "lists all week_planners", %{conn: conn, week_planner: week_planner} do
      {:ok, _index_live, html} = live(conn, Routes.week_planner_index_path(conn, :index))

      assert html =~ "Listing Week planners"
    end

    test "saves new week_planner", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.week_planner_index_path(conn, :index))

      assert index_live |> element("a", "New Week planner") |> render_click() =~
               "New Week planner"

      assert_patch(index_live, Routes.week_planner_index_path(conn, :new))

      assert index_live
             |> form("#week_planner-form", week_planner: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#week_planner-form", week_planner: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.week_planner_index_path(conn, :index))

      assert html =~ "Week planner created successfully"
    end

    test "updates week_planner in listing", %{conn: conn, week_planner: week_planner} do
      {:ok, index_live, _html} = live(conn, Routes.week_planner_index_path(conn, :index))

      assert index_live |> element("#week_planner-#{week_planner.id} a", "Edit") |> render_click() =~
               "Edit Week planner"

      assert_patch(index_live, Routes.week_planner_index_path(conn, :edit, week_planner))

      assert index_live
             |> form("#week_planner-form", week_planner: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#week_planner-form", week_planner: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.week_planner_index_path(conn, :index))

      assert html =~ "Week planner updated successfully"
    end

    test "deletes week_planner in listing", %{conn: conn, week_planner: week_planner} do
      {:ok, index_live, _html} = live(conn, Routes.week_planner_index_path(conn, :index))

      assert index_live |> element("#week_planner-#{week_planner.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#week_planner-#{week_planner.id}")
    end
  end

  describe "Show" do
    setup [:create_week_planner]

    test "displays week_planner", %{conn: conn, week_planner: week_planner} do
      {:ok, _show_live, html} = live(conn, Routes.week_planner_show_path(conn, :show, week_planner))

      assert html =~ "Show Week planner"
    end

    test "updates week_planner within modal", %{conn: conn, week_planner: week_planner} do
      {:ok, show_live, _html} = live(conn, Routes.week_planner_show_path(conn, :show, week_planner))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Week planner"

      assert_patch(show_live, Routes.week_planner_show_path(conn, :edit, week_planner))

      assert show_live
             |> form("#week_planner-form", week_planner: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#week_planner-form", week_planner: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.week_planner_show_path(conn, :show, week_planner))

      assert html =~ "Week planner updated successfully"
    end
  end
end
