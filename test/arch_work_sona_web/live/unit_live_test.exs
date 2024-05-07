defmodule ArchWorkSonaWeb.UnitLiveTest do
  use ArchWorkSonaWeb.ConnCase

  import Phoenix.LiveViewTest
  import ArchWorkSona.ItemsFixtures

  @create_attrs %{name: "some name", description: "some description", sname: "some sname"}
  @update_attrs %{name: "some updated name", description: "some updated description", sname: "some updated sname"}
  @invalid_attrs %{name: nil, description: nil, sname: nil}

  defp create_unit(_) do
    unit = unit_fixture()
    %{unit: unit}
  end

  describe "Index" do
    setup [:create_unit]

    test "lists all units", %{conn: conn, unit: unit} do
      {:ok, _index_live, html} = live(conn, ~p"/units")

      assert html =~ "Listing Units"
      assert html =~ unit.name
    end

    test "saves new unit", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/units")

      assert index_live |> element("a", "New Unit") |> render_click() =~
               "New Unit"

      assert_patch(index_live, ~p"/units/new")

      assert index_live
             |> form("#unit-form", unit: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#unit-form", unit: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/units")

      html = render(index_live)
      assert html =~ "Unit created successfully"
      assert html =~ "some name"
    end

    test "updates unit in listing", %{conn: conn, unit: unit} do
      {:ok, index_live, _html} = live(conn, ~p"/units")

      assert index_live |> element("#units-#{unit.id} a", "Edit") |> render_click() =~
               "Edit Unit"

      assert_patch(index_live, ~p"/units/#{unit}/edit")

      assert index_live
             |> form("#unit-form", unit: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#unit-form", unit: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/units")

      html = render(index_live)
      assert html =~ "Unit updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes unit in listing", %{conn: conn, unit: unit} do
      {:ok, index_live, _html} = live(conn, ~p"/units")

      assert index_live |> element("#units-#{unit.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#units-#{unit.id}")
    end
  end

  describe "Show" do
    setup [:create_unit]

    test "displays unit", %{conn: conn, unit: unit} do
      {:ok, _show_live, html} = live(conn, ~p"/units/#{unit}")

      assert html =~ "Show Unit"
      assert html =~ unit.name
    end

    test "updates unit within modal", %{conn: conn, unit: unit} do
      {:ok, show_live, _html} = live(conn, ~p"/units/#{unit}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Unit"

      assert_patch(show_live, ~p"/units/#{unit}/show/edit")

      assert show_live
             |> form("#unit-form", unit: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#unit-form", unit: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/units/#{unit}")

      html = render(show_live)
      assert html =~ "Unit updated successfully"
      assert html =~ "some updated name"
    end
  end
end
