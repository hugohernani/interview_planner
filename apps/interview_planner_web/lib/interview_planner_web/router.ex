defmodule InterviewPlannerWeb.Router do
  use InterviewPlannerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {InterviewPlannerWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", InterviewPlannerWeb do
    pipe_through :browser

    live "/", PageLive, :index

    live "/meetings", MeetingLive.Index, :index
    live "/meetings/new", MeetingLive.Index, :new
    live "/meetings/:id/edit", MeetingLive.Index, :edit

    live "/meetings/:id", MeetingLive.Show, :show
    live "/meetings/:id/show/edit", MeetingLive.Show, :edit

    live "/week_planners", WeekPlannerLive.Index, :index
    live "/week_planners/new", WeekPlannerLive.Index, :new
    live "/week_planners/:id/edit", WeekPlannerLive.Index, :edit

    live "/week_planners/:id", WeekPlannerLive.Show, :show
    live "/week_planners/:id/show/edit", WeekPlannerLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", InterviewPlannerWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: InterviewPlannerWeb.Telemetry
    end
  end
end
