defmodule UrlShortenerWeb.ShortedUrlController do
  use UrlShortenerWeb, :controller

  alias UrlShortener.Shortener
  alias UrlShortener.Shortener.ShortedUrl

  def index(conn, _params) do
    changeset = Shortener.change_shorted_url(%ShortedUrl{})
    render(conn, :index, changeset: changeset )
  end

  def create(conn, %{"shorted_url" => shorted_url_params}) do
    case Shortener.create_shorted_url(shorted_url_params) do
      {:ok, shorted_url} ->
        conn
        |> put_flash(:info, "Shorted url created successfully!")
        |> redirect(to: ~p"/#{shorted_url}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :index, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    shorted_url = Shortener.get_shorted_url!(id)
    render(conn, :show, shorted_url: shorted_url, base_url: UrlShortenerWeb.Endpoint.url())
  end

  def edit(conn, %{"id" => id}) do
    shorted_url = Shortener.get_shorted_url!(id)
    changeset = Shortener.change_shorted_url(shorted_url)
    render(conn, :edit, shorted_url: shorted_url, changeset: changeset)
  end

  def redirect_to_original_url(conn, %{"shorted_url" => shorted_url}) do
    case Shortener.get_original_url_by_shorted_url(shorted_url) do
      {:ok, original_url} -> redirect(conn, external: original_url)
      {:error, _} -> redirect(conn, to: ~p"/")
    end
  end

  def update(conn, %{"id" => id, "shorted_url" => shorted_url_params}) do
    shorted_url = Shortener.get_shorted_url!(id)

    case Shortener.update_shorted_url(shorted_url, shorted_url_params) do
      {:ok, shorted_url} ->
        conn
        |> put_flash(:info, "Shorted url updated successfully.")
        |> redirect(to: ~p"/#{shorted_url}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, shorted_url: shorted_url, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    shorted_url = Shortener.get_shorted_url!(id)
    {:ok, _shorted_url} = Shortener.delete_shorted_url(shorted_url)

    conn
    |> put_flash(:info, "Shorted url deleted successfully.")
    |> redirect(to: ~p"/")
  end
end
