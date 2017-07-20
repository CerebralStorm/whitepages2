defmodule Whitepages2.Router do
  use Whitepages2.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    #plug PlugLti
    #plug :protect_from_forgery
    #plug :put_secure_browser_headers
  end

  pipeline :lti do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Whitepages2 do
    pipe_through :browser # Use the default browser stack

    get "/", LtiController, :index
    resources "/organizations", OrganizationController do
      resources "/users", UserController
      resources "/courses", CourseController
      resources "/enrollments", EnrollmentController, except: [:new, :edit]
      resources "/sections", SectionController, except: [:new, :edit]
      resources "/tables", TableController, except: [:new, :edit] do
        resources "/table_rows", TableRowController, except: [:new, :edit]
      end
    end
  end

  scope "/lti", Whitepages2 do
    pipe_through :browser

    get "/config.xml", LtiController, :config
    get "/config", LtiController, :config
    post "/account", LtiController, :account
    post "/course", LtiController, :course
  end

  # Other scopes may use custom stacks.
  # scope "/api", Whitepages2 do
  #   pipe_through :api
  # end
end
