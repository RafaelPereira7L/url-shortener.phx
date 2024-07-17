defmodule UrlShortener.ShortenerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `UrlShortener.Shortener` context.
  """

  @doc """
  Generate a shorted_url.
  """
  def shorted_url_fixture(attrs \\ %{}) do
    {:ok, shorted_url} =
      attrs
      |> Enum.into(%{
        number_of_visits: 42,
        original_url: "some original_url",
        shorted_url: "some shorted_url"
      })
      |> UrlShortener.Shortener.create_shorted_url()

    shorted_url
  end
end
