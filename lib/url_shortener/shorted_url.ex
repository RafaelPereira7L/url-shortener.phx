defmodule UrlShortener.ShortedUrl do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shorted_urls" do
    field :shorted_url, :string
    field :original_url, :string
    field :number_of_visits, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(shorted_url, attrs) do
    shorted_url
    |> cast(attrs, [:shorted_url, :original_url, :number_of_visits])
    |> validate_required([:shorted_url, :original_url, :number_of_visits])
  end
end
