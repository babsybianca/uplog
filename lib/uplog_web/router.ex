"""
Author: Arian Allenson Valdez
This is a course requirement for CS 192
Software Engineering II under the
supervision of Asst. Prof. Ma. Rowena C.
Solamo of the Department of Computer
Science, College of Engineering, University
of the Philippines, Diliman for the AY 2019-
2020
"""

defmodule UplogWeb.Router do
  use UplogWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", UplogWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/", UplogWeb do
    pipe_through [:browser, :protected]

    resources "/organizations", OrganizationController do
      post "/add_admin", OrganizationController, :add_admin, as: :add_admin
      resources "/items", BorrowableItemController do
        resources "/borrow_requests", BorrowRequestController do
          post "/approve", BorrowRequestController, :approve, as: :approve
          post "/deny", BorrowRequestController, :deny, as: :deny
        end
      end
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", UplogWeb do
  #   pipe_through :api
  # end
end
