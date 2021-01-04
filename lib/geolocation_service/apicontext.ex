defmodule GeolocationService.Apicontext do
  alias GeolocationService.Repo
  alias GeolocationService.GeolocationSchema
  alias GeolocationService.Apicontext.Validations
  @file_path Application.get_env(:geolocation_service, :file_path)

  def seed_geo_location_data() do
    @file_path
    |> File.stream!()
    |> CSV.decode!(headers: true)
    |> Enum.each(fn row ->
      with {:ok, :valid} <- Validations.validate_seed_data(row) do
        attrs = %{
          ip_address: row["ip_address"],
          country_code: row["country_code"],
          country: row["country"],
          city: row["city"],
          latitude: row["latitude"],
          longitude: row["longitude"],
          mystery_value: row["mystery_value"]
        }

        case get_location_by_ip(attrs[:ip_address]) do
          {:no_result, []} ->
            %GeolocationSchema{}
            |> GeolocationSchema.changeset(attrs)
            |> Repo.insert!()

          {:ok, data} ->
            data |> GeolocationSchema.changeset(attrs) |> Repo.update!()
        end
      else
        {:error, :malformed} ->
          :ok
      end
    end)
  end

  def get_location_by_ip(ip) do
    case Repo.get_by(GeolocationSchema, ip_address: ip) do
      nil ->
        {:no_result, []}

      data ->
        {:ok, data}
    end
  end

  defmodule Validations do
    def validate_seed_data(geo_data) do
      with value_list <- Map.values(geo_data),
           7 <- length(value_list),
           false <- Enum.any?(value_list, fn gd -> gd in ["", nil] end),
           {:ok, _ip} <- validate("ip_address", geo_data["ip_address"]),
           true <- validate("geo", geo_data["latitude"]),
           true <- validate("geo", geo_data["longitude"]) do
           # Note: We can add validation for other fields incse of known format
        {:ok, :valid}
      else
        _ ->
          {:error, :malformed}
      end
    end

    def validate("ip_address", ip_address) do
      ip_address |> to_charlist |> :inet.parse_address()
    end

    def validate("geo", geo_cordinate) do
      case Float.parse(geo_cordinate) do
        {float, ""} -> true
        :error -> false
        _ -> false
      end
    end
  end
end
