defmodule UrlShortener.Shortener do
  @moduledoc """
  The Shortener context.
  """

  import Ecto.Query, warn: false
  alias UrlShortener.Repo

  alias UrlShortener.Shortener.ShortedUrl

  @doc """
  Returns the list of shorted_urls.

  ## Examples

      iex> list_shorted_urls()
      [%ShortedUrl{}, ...]

  """
  def list_shorted_urls do
    Repo.all(ShortedUrl)
  end

  @doc """
  Gets a single shorted_url.

  Raises `Ecto.NoResultsError` if the Shorted url does not exist.

  ## Examples

      iex> get_shorted_url!(123)
      %ShortedUrl{}

      iex> get_shorted_url!(456)
      ** (Ecto.NoResultsError)

  """
  def get_shorted_url!(id), do: Repo.get!(ShortedUrl, id)

  @doc """
  Creates a shorted_url.

  ## Examples

      iex> create_shorted_url(%{field: value})
      {:ok, %ShortedUrl{}}

      iex> create_shorted_url(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shorted_url(attrs \\ %{}) do
    %ShortedUrl{}
    |> ShortedUrl.changeset(%{
      shorted_url: generate_short_url(),
      original_url: attrs["original_url"]
    })
    |> Repo.insert()
  end

  @doc """
  Updates a shorted_url.

  ## Examples

      iex> update_shorted_url(shorted_url, %{field: new_value})
      {:ok, %ShortedUrl{}}

      iex> update_shorted_url(shorted_url, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_shorted_url(%ShortedUrl{} = shorted_url, attrs) do
    shorted_url
    |> ShortedUrl.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a shorted_url.

  ## Examples

      iex> delete_shorted_url(shorted_url)
      {:ok, %ShortedUrl{}}

      iex> delete_shorted_url(shorted_url)
      {:error, %Ecto.Changeset{}}

  """
  def delete_shorted_url(%ShortedUrl{} = shorted_url) do
    Repo.delete(shorted_url)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking shorted_url changes.

  ## Examples

      iex> change_shorted_url(shorted_url)
      %Ecto.Changeset{data: %ShortedUrl{}}

  """
  def change_shorted_url(%ShortedUrl{} = shorted_url, attrs \\ %{}) do
    ShortedUrl.changeset(shorted_url, attrs)
  end

  def increase_visits(%ShortedUrl{} = shorted_url) do
    shorted_url
    |> Ecto.Changeset.change(number_of_visits: shorted_url.number_of_visits + 1)
    |> Repo.update()
  end

  def get_original_url_by_shorted_url(shorted_url) do
    case Repo.one(from(s in ShortedUrl, where: s.shorted_url == ^shorted_url)) do
      nil ->
        {:error, "Shorted url not found"}
      shorted_url ->
        increase_visits(shorted_url)
        {:ok, shorted_url.original_url}
    end
  end

  def generate_short_url() do
    :crypto.strong_rand_bytes(5)
    |> Base.encode64()
    |> String.replace("+", "-")
    |> String.replace("/", "_")
    |> String.replace("=", "")
    |> String.slice(0..9)
  end
end
