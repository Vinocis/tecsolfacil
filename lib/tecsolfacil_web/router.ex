defmodule TecsolfacilWeb.Router do
  use TecsolfacilWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TecsolfacilWeb.Api, as: :api do
    pipe_through :api

    scope "/v1", V1, as: :v1 do
      get "/address/:cep", AddressController, :show
    end
  end
end
