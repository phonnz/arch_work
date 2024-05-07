defmodule ArchWorkSonaWeb.BudgetLiveTest do
  use ArchWorkSonaWeb.ConnCase

  import Phoenix.LiveViewTest
  import ArchWorkSona.FinancialFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_budget(_) do
    budget = budget_fixture()
    %{budget: budget}
  end

  describe "Index" do
    setup [:create_budget]

    test "lists all budgets", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/budgets")

      assert html =~ "Listing Budgets"
    end

    test "saves new budget", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/budgets")

      assert index_live |> element("a", "New Budget") |> render_click() =~
               "New Budget"

      assert_patch(index_live, ~p"/budgets/new")

      assert index_live
             |> form("#budget-form", budget: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#budget-form", budget: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/budgets")

      html = render(index_live)
      assert html =~ "Budget created successfully"
    end

    test "updates budget in listing", %{conn: conn, budget: budget} do
      {:ok, index_live, _html} = live(conn, ~p"/budgets")

      assert index_live |> element("#budgets-#{budget.id} a", "Edit") |> render_click() =~
               "Edit Budget"

      assert_patch(index_live, ~p"/budgets/#{budget}/edit")

      assert index_live
             |> form("#budget-form", budget: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#budget-form", budget: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/budgets")

      html = render(index_live)
      assert html =~ "Budget updated successfully"
    end

    test "deletes budget in listing", %{conn: conn, budget: budget} do
      {:ok, index_live, _html} = live(conn, ~p"/budgets")

      assert index_live |> element("#budgets-#{budget.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#budgets-#{budget.id}")
    end
  end

  describe "Show" do
    setup [:create_budget]

    test "displays budget", %{conn: conn, budget: budget} do
      {:ok, _show_live, html} = live(conn, ~p"/budgets/#{budget}")

      assert html =~ "Show Budget"
    end

    test "updates budget within modal", %{conn: conn, budget: budget} do
      {:ok, show_live, _html} = live(conn, ~p"/budgets/#{budget}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Budget"

      assert_patch(show_live, ~p"/budgets/#{budget}/show/edit")

      assert show_live
             |> form("#budget-form", budget: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#budget-form", budget: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/budgets/#{budget}")

      html = render(show_live)
      assert html =~ "Budget updated successfully"
    end
  end
end
