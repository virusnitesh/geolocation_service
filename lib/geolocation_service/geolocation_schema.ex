defmodule GeolocationService.GeolocationSchema do
  use Ecto.Schema
  import Ecto.Changeset
  alias GeolocationService.GeolocationSchema

  schema "geolocation" do
    field :ip_address, :string
    field :country_code, :string
    field :country, :string
    field :city, :string
    field :latitude, :float
    field :longitude, :float
    field :mystery_value, :string

    timestamps()
  end

  @doc false
  def changeset(%GeolocationSchema{} = geolocation, attrs) do
    geolocation
    |> cast(attrs, [
      :id,
      :ip_address,
      :country_code,
      :country,
      :city,
      :latitude,
      :longitude,
      :mystery_value
    ])
    |> validate_required([:ip_address])
  end
end
