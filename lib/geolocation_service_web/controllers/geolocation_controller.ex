defmodule GeolocationServiceWeb.GeolocationController do
  use GeolocationServiceWeb, :controller
  alias GeolocationService.Apicontext

  def search_geo_location_by_ip(conn, params) do
    case conn.method do
      "GET" ->
        render(conn, "search.html", geo_data: "")

      "POST" ->
        with {:ok, _d} <- Apicontext.Validations.validate("ip_address", params["ip"]),
             {:ok, data} <- Apicontext.get_location_by_ip(params["ip"]) do
          geo_data = %{
            ip: data.ip_address,
            country_code: data.country_code,
            country: data.country,
            city: data.city,
            latitude: data.latitude,
            longitude: data.longitude,
            mystery_value: data.mystery_value
          }

          render(conn, "search.html", geo_data: geo_data)
        else
          {:no_result, _a} ->
            conn
            |> put_flash(:info, "No data for provided IP")
            |> render("search.html", geo_data: "")

          _ ->
            conn
            |> put_flash(:error, "Invalid IP")
            |> render("search.html", geo_data: "")
        end
    end
  end
end
