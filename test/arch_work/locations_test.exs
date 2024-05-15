defmodule ArchWork.LocationsTest do
  use ArchWork.DataCase

  alias ArchWork.Locations

  describe "buildings" do
    alias ArchWork.Locations.Building

    import ArchWork.LocationsFixtures

    @invalid_attrs %{name: nil, address: nil, start_date: nil, end_date: nil}

    test "list_buildings/0 returns all buildings" do
      building = building_fixture()
      assert Locations.list_buildings() == [building]
    end

    test "get_building!/1 returns the building with given id" do
      building = building_fixture()
      assert Locations.get_building!(building.id) == building
    end

    test "create_building/1 with valid data creates a building" do
      valid_attrs = %{name: "some name", address: "some address", start_date: ~D[2024-05-13], end_date: ~D[2024-05-13]}

      assert {:ok, %Building{} = building} = Locations.create_building(valid_attrs)
      assert building.name == "some name"
      assert building.address == "some address"
      assert building.start_date == ~D[2024-05-13]
      assert building.end_date == ~D[2024-05-13]
    end

    test "create_building/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_building(@invalid_attrs)
    end

    test "update_building/2 with valid data updates the building" do
      building = building_fixture()
      update_attrs = %{name: "some updated name", address: "some updated address", start_date: ~D[2024-05-14], end_date: ~D[2024-05-14]}

      assert {:ok, %Building{} = building} = Locations.update_building(building, update_attrs)
      assert building.name == "some updated name"
      assert building.address == "some updated address"
      assert building.start_date == ~D[2024-05-14]
      assert building.end_date == ~D[2024-05-14]
    end

    test "update_building/2 with invalid data returns error changeset" do
      building = building_fixture()
      assert {:error, %Ecto.Changeset{}} = Locations.update_building(building, @invalid_attrs)
      assert building == Locations.get_building!(building.id)
    end

    test "delete_building/1 deletes the building" do
      building = building_fixture()
      assert {:ok, %Building{}} = Locations.delete_building(building)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_building!(building.id) end
    end

    test "change_building/1 returns a building changeset" do
      building = building_fixture()
      assert %Ecto.Changeset{} = Locations.change_building(building)
    end
  end

  describe "posts" do
    alias ArchWork.Locations.Posts

    import ArchWork.LocationsFixtures

    @invalid_attrs %{content: nil, votes: nil}

    test "list_posts/0 returns all posts" do
      posts = posts_fixture()
      assert Locations.list_posts() == [posts]
    end

    test "get_posts!/1 returns the posts with given id" do
      posts = posts_fixture()
      assert Locations.get_posts!(posts.id) == posts
    end

    test "create_posts/1 with valid data creates a posts" do
      valid_attrs = %{content: "some content", votes: 42}

      assert {:ok, %Posts{} = posts} = Locations.create_posts(valid_attrs)
      assert posts.content == "some content"
      assert posts.votes == 42
    end

    test "create_posts/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_posts(@invalid_attrs)
    end

    test "update_posts/2 with valid data updates the posts" do
      posts = posts_fixture()
      update_attrs = %{content: "some updated content", votes: 43}

      assert {:ok, %Posts{} = posts} = Locations.update_posts(posts, update_attrs)
      assert posts.content == "some updated content"
      assert posts.votes == 43
    end

    test "update_posts/2 with invalid data returns error changeset" do
      posts = posts_fixture()
      assert {:error, %Ecto.Changeset{}} = Locations.update_posts(posts, @invalid_attrs)
      assert posts == Locations.get_posts!(posts.id)
    end

    test "delete_posts/1 deletes the posts" do
      posts = posts_fixture()
      assert {:ok, %Posts{}} = Locations.delete_posts(posts)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_posts!(posts.id) end
    end

    test "change_posts/1 returns a posts changeset" do
      posts = posts_fixture()
      assert %Ecto.Changeset{} = Locations.change_posts(posts)
    end
  end
end
