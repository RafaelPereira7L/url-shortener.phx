defmodule UrlShortenerWeb.ShortedUrlHTML do
  use UrlShortenerWeb, :html

  embed_templates "shorted_url_html/*"

  @doc """
  Renders a shorted_url form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def shorted_url_form(assigns)
end
