defmodule ArchWorkSona.LocationsTest do
  use ArchWorkSona.DataCase

  alias ArchWorkSona.Locations

  describe "buildings" do
    alias ArchWorkSona.Locations.Building

    import ArchWorkSona.LocationsFixtures

    @invalid_attrs %{name: nil, address: nil}

    test "list_buildings/0 returns all buildings" do
      building = building_fixture()
      assert Locations.list_buildings() == [building]
    end

    test "get_building!/1 returns the building with given id" do
      building = building_fixture()
      assert Locations.get_building!(building.id) == building
    end

    test "create_building/1 with valid data creates a building" do
      valid_attrs = %{name: "some name", address: "some address"}

      assert {:ok, %Building{} = building} = Locations.create_building(valid_attrs)
      assert building.name == "some name"
      assert building.address == "some address"
    end

    test "create_building/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_building(@invalid_attrs)
    end

    test "update_building/2 with valid data updates the building" do
      building = building_fixture()
      update_attrs = %{name: "some updated name", address: "some updated address"}

      assert {:ok, %Building{} = building} = Locations.update_building(building, update_attrs)
      assert building.name == "some updated name"
      assert building.address == "some updated address"
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

  describe "comments" do
    alias ArchWorkSona.Locations.Comment

    import ArchWorkSona.LocationsFixtures

    @invalid_attrs %{content: nil, up_votes: nil}

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Locations.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Locations.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      valid_attrs = %{content: "some content", up_votes: 42}

      assert {:ok, %Comment{} = comment} = Locations.create_comment(valid_attrs)
      assert comment.content == "some content"
      assert comment.up_votes == 42
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      update_attrs = %{content: "some updated content", up_votes: 43}

      assert {:ok, %Comment{} = comment} = Locations.update_comment(comment, update_attrs)
      assert comment.content == "some updated content"
      assert comment.up_votes == 43
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Locations.update_comment(comment, @invalid_attrs)
      assert comment == Locations.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Locations.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Locations.change_comment(comment)
    end
  end
end
