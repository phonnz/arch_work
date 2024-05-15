defmodule ArchWorkWeb.BuildingLiveTest do
  use ArchWorkWeb.ConnCase

  import Phoenix.LiveViewTest
  import ArchWork.LocationsFixtures

  @create_attrs %{name: "some name", address: "some address", start_date: "2024-05-13", end_date: "2024-05-13"}
  @update_attrs %{name: "some updated name", address: "some updated address", start_date: "2024-05-14", end_date: "2024-05-14"}
  @invalid_attrs %{name: nil, address: nil, start_date: nil, end_date: nil}

  defp create_building(_) do
    building = building_fixture()
    %{building: building}
  end

  describe "Index" do
    setup [:create_building]

    test "lists all buildings", %{conn: conn, building: building} do
      {:ok, _index_live, html} = live(conn, ~p"/buildings")

      assert html =~ "Listing Buildings"
      assert html =~ building.name
    end

    test "saves new building", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/buildings")

      assert index_live |> element("a", "New Building") |> render_click() =~
               "New Building"

      assert_patch(index_live, ~p"/buildings/new")

      assert index_live
             |> form("#building-form", building: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#building-form", building: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/buildings")

      html = render(index_live)
      assert html =~ "Building created successfully"
      assert html =~ "some name"
    end

    test "updates building in listing", %{conn: conn, building: building} do
      {:ok, index_live, _html} = live(conn, ~p"/buildings")

      assert index_live |> element("#buildings-#{building.id} a", "Edit") |> render_click() =~
               "Edit Building"

      assert_patch(index_live, ~p"/buildings/#{building}/edit")

      assert index_live
             |> form("#building-form", building: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#building-form", building: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/buildings")

      html = render(index_live)
      assert html =~ "Building updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes building in listing", %{conn: conn, building: building} do
      {:ok, index_live, _html} = live(conn, ~p"/buildings")

      assert index_live |> element("#buildings-#{building.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#buildings-#{building.id}")
    end
  end

  describe "Show" do
    setup [:create_building]

    test "displays building", %{conn: conn, building: building} do
      {:ok, _show_live, html} = live(conn, ~p"/buildings/#{building}")

      assert html =~ "Show Building"
      assert html =~ building.name
    end

    test "updates building within modal", %{conn: conn, building: building} do
      {:ok, show_live, _html} = live(conn, ~p"/buildings/#{building}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Building"

      assert_patch(show_live, ~p"/buildings/#{building}/show/edit")

      assert show_live
             |> form("#building-form", building: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#building-form", building: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/buildings/#{building}")

      html = render(show_live)
      assert html =~ "Building updated successfully"
      assert html =~ "some updated name"
    end
  end
end
