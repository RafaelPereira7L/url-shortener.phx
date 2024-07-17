defmodule UrlShortenerWeb.ShortedUrlControllerTest do
  use UrlShortenerWeb.ConnCase

  import UrlShortener.ShortenerFixtures

  @create_attrs %{shorted_url: "some shorted_url", original_url: "some original_url", number_of_visits: 42}
  @update_attrs %{shorted_url: "some updated shorted_url", original_url: "some updated original_url", number_of_visits: 43}
  @invalid_attrs %{shorted_url: nil, original_url: nil, number_of_visits: nil}

  describe "index" do
    test "lists all shorted_urls", %{conn: conn} do
      conn = get(conn, ~p"/shorted_urls")
      assert html_response(conn, 200) =~ "Listing Shorted urls"
    end
  end

  describe "new shorted_url" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/shorted_urls/new")
      assert html_response(conn, 200) =~ "New Shorted url"
    end
  end

  describe "create shorted_url" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/shorted_urls", shorted_url: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/shorted_urls/#{id}"

      conn = get(conn, ~p"/shorted_urls/#{id}")
      assert html_response(conn, 200) =~ "Shorted url #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/shorted_urls", shorted_url: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Shorted url"
    end
  end

  describe "edit shorted_url" do
    setup [:create_shorted_url]

    test "renders form for editing chosen shorted_url", %{conn: conn, shorted_url: shorted_url} do
      conn = get(conn, ~p"/shorted_urls/#{shorted_url}/edit")
      assert html_response(conn, 200) =~ "Edit Shorted url"
    end
  end

  describe "update shorted_url" do
    setup [:create_shorted_url]

    test "redirects when data is valid", %{conn: conn, shorted_url: shorted_url} do
      conn = put(conn, ~p"/shorted_urls/#{shorted_url}", shorted_url: @update_attrs)
      assert redirected_to(conn) == ~p"/shorted_urls/#{shorted_url}"

      conn = get(conn, ~p"/shorted_urls/#{shorted_url}")
      assert html_response(conn, 200) =~ "some updated shorted_url"
    end

    test "renders errors when data is invalid", %{conn: conn, shorted_url: shorted_url} do
      conn = put(conn, ~p"/shorted_urls/#{shorted_url}", shorted_url: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Shorted url"
    end
  end

  describe "delete shorted_url" do
    setup [:create_shorted_url]

    test "deletes chosen shorted_url", %{conn: conn, shorted_url: shorted_url} do
      conn = delete(conn, ~p"/shorted_urls/#{shorted_url}")
      assert redirected_to(conn) == ~p"/shorted_urls"

      assert_error_sent 404, fn ->
        get(conn, ~p"/shorted_urls/#{shorted_url}")
      end
    end
  end

  defp create_shorted_url(_) do
    shorted_url = shorted_url_fixture()
    %{shorted_url: shorted_url}
  end
end
