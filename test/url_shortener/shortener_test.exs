defmodule UrlShortener.ShortenerTest do
  use UrlShortener.DataCase

  alias UrlShortener.Shortener

  describe "shorted_urls" do
    alias UrlShortener.Shortener.ShortedUrl

    import UrlShortener.ShortenerFixtures

    @invalid_attrs %{shorted_url: nil, original_url: nil, number_of_visits: nil}

    test "list_shorted_urls/0 returns all shorted_urls" do
      shorted_url = shorted_url_fixture()
      assert Shortener.list_shorted_urls() == [shorted_url]
    end

    test "get_shorted_url!/1 returns the shorted_url with given id" do
      shorted_url = shorted_url_fixture()
      assert Shortener.get_shorted_url!(shorted_url.id) == shorted_url
    end

    test "create_shorted_url/1 with valid data creates a shorted_url" do
      valid_attrs = %{shorted_url: "some shorted_url", original_url: "some original_url", number_of_visits: 42}

      assert {:ok, %ShortedUrl{} = shorted_url} = Shortener.create_shorted_url(valid_attrs)
      assert shorted_url.shorted_url == "some shorted_url"
      assert shorted_url.original_url == "some original_url"
      assert shorted_url.number_of_visits == 42
    end

    test "create_shorted_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shortener.create_shorted_url(@invalid_attrs)
    end

    test "update_shorted_url/2 with valid data updates the shorted_url" do
      shorted_url = shorted_url_fixture()
      update_attrs = %{shorted_url: "some updated shorted_url", original_url: "some updated original_url", number_of_visits: 43}

      assert {:ok, %ShortedUrl{} = shorted_url} = Shortener.update_shorted_url(shorted_url, update_attrs)
      assert shorted_url.shorted_url == "some updated shorted_url"
      assert shorted_url.original_url == "some updated original_url"
      assert shorted_url.number_of_visits == 43
    end

    test "update_shorted_url/2 with invalid data returns error changeset" do
      shorted_url = shorted_url_fixture()
      assert {:error, %Ecto.Changeset{}} = Shortener.update_shorted_url(shorted_url, @invalid_attrs)
      assert shorted_url == Shortener.get_shorted_url!(shorted_url.id)
    end

    test "delete_shorted_url/1 deletes the shorted_url" do
      shorted_url = shorted_url_fixture()
      assert {:ok, %ShortedUrl{}} = Shortener.delete_shorted_url(shorted_url)
      assert_raise Ecto.NoResultsError, fn -> Shortener.get_shorted_url!(shorted_url.id) end
    end

    test "change_shorted_url/1 returns a shorted_url changeset" do
      shorted_url = shorted_url_fixture()
      assert %Ecto.Changeset{} = Shortener.change_shorted_url(shorted_url)
    end
  end
end
