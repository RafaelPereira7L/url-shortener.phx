defmodule UrlShortener.Repo.Migrations.CreateShortedUrls do
  use Ecto.Migration

  def change do
    create table(:shorted_urls) do
      add :shorted_url, :string
      add :original_url, :string
      add :number_of_visits, :integer, default: 0

      timestamps(type: :utc_datetime)
    end
  end
end
