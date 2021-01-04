defmodule GeolocationServiceWeb.Router do
  use GeolocationServiceWeb, :router

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

  scope "/", GeolocationServiceWeb do
    pipe_through :browser

    get "/", PageController, :index
    # get "/search", GeolocationController, :fetch_geolocation_data
    get "/search_geo_data", GeolocationController, :search_geo_location_by_ip
    post "/search_geo_data", GeolocationController, :search_geo_location_by_ip
  end

  # Other scopes may use custom stacks.
  # scope "/api", GeolocationServiceWeb do
  #   pipe_through :api
  # end
end
