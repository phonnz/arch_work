defmodule ArchWorkSona.ItemsTest do
  use ArchWorkSona.DataCase

  alias ArchWorkSona.Items

  describe "units" do
    alias ArchWorkSona.Items.Unit

    import ArchWorkSona.ItemsFixtures

    @invalid_attrs %{name: nil, description: nil, sname: nil}

    test "list_units/0 returns all units" do
      unit = unit_fixture()
      assert Items.list_units() == [unit]
    end

    test "get_unit!/1 returns the unit with given id" do
      unit = unit_fixture()
      assert Items.get_unit!(unit.id) == unit
    end

    test "create_unit/1 with valid data creates a unit" do
      valid_attrs = %{name: "some name", description: "some description", sname: "some sname"}

      assert {:ok, %Unit{} = unit} = Items.create_unit(valid_attrs)
      assert unit.name == "some name"
      assert unit.description == "some description"
      assert unit.sname == "some sname"
    end

    test "create_unit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Items.create_unit(@invalid_attrs)
    end

    test "update_unit/2 with valid data updates the unit" do
      unit = unit_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", sname: "some updated sname"}

      assert {:ok, %Unit{} = unit} = Items.update_unit(unit, update_attrs)
      assert unit.name == "some updated name"
      assert unit.description == "some updated description"
      assert unit.sname == "some updated sname"
    end

    test "update_unit/2 with invalid data returns error changeset" do
      unit = unit_fixture()
      assert {:error, %Ecto.Changeset{}} = Items.update_unit(unit, @invalid_attrs)
      assert unit == Items.get_unit!(unit.id)
    end

    test "delete_unit/1 deletes the unit" do
      unit = unit_fixture()
      assert {:ok, %Unit{}} = Items.delete_unit(unit)
      assert_raise Ecto.NoResultsError, fn -> Items.get_unit!(unit.id) end
    end

    test "change_unit/1 returns a unit changeset" do
      unit = unit_fixture()
      assert %Ecto.Changeset{} = Items.change_unit(unit)
    end
  end

  describe "items" do
    alias ArchWorkSona.Items.Item

    import ArchWorkSona.ItemsFixtures

    @invalid_attrs %{name: nil, fixed_price: nil}

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Items.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Items.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{name: "some name", fixed_price: 42}

      assert {:ok, %Item{} = item} = Items.create_item(valid_attrs)
      assert item.name == "some name"
      assert item.fixed_price == 42
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Items.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      update_attrs = %{name: "some updated name", fixed_price: 43}

      assert {:ok, %Item{} = item} = Items.update_item(item, update_attrs)
      assert item.name == "some updated name"
      assert item.fixed_price == 43
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Items.update_item(item, @invalid_attrs)
      assert item == Items.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Items.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Items.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Items.change_item(item)
    end
  end
end
