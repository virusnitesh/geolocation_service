defmodule GeolocationService.Repo.Migrations.CreateGeolocationSchema do
  use Ecto.Migration

  def change do
    create table(:geolocation) do
      add :ip_address, :string
      add :country_code, :string
      add :country, :string
      add :city, :string
      add :latitude, :float
      add :longitude, :float
      add :mystery_value, :string

      timestamps()
    end
  end
end
