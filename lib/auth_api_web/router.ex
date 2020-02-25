defmodule AuthApiWeb.Router do
  use AuthApiWeb, :router
  use Pow.Phoenix.Router
  use Pow.Extension.Phoenix.Router, otp_app: :auth_api


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

  # BEGIN added for Pow
  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
    error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_extension_routes()
  end

  scope "/", AuthApiWeb do
    pipe_through [:browser, :protected]
    resources "/products", ProductController
  end
  # END added for Pow

  scope "/", AuthApiWeb do
    pipe_through :browser

    get "/", PageController, :index
   
  end
end
