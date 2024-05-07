defmodule ArchWorkSona.FinancialTest do
  use ArchWorkSona.DataCase

  alias ArchWorkSona.Financial

  describe "budgets" do
    alias ArchWorkSona.Financial.Budget

    import ArchWorkSona.FinancialFixtures

    @invalid_attrs %{}

    test "list_budgets/0 returns all budgets" do
      budget = budget_fixture()
      assert Financial.list_budgets() == [budget]
    end

    test "get_budget!/1 returns the budget with given id" do
      budget = budget_fixture()
      assert Financial.get_budget!(budget.id) == budget
    end

    test "create_budget/1 with valid data creates a budget" do
      valid_attrs = %{}

      assert {:ok, %Budget{} = budget} = Financial.create_budget(valid_attrs)
    end

    test "create_budget/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Financial.create_budget(@invalid_attrs)
    end

    test "update_budget/2 with valid data updates the budget" do
      budget = budget_fixture()
      update_attrs = %{}

      assert {:ok, %Budget{} = budget} = Financial.update_budget(budget, update_attrs)
    end

    test "update_budget/2 with invalid data returns error changeset" do
      budget = budget_fixture()
      assert {:error, %Ecto.Changeset{}} = Financial.update_budget(budget, @invalid_attrs)
      assert budget == Financial.get_budget!(budget.id)
    end

    test "delete_budget/1 deletes the budget" do
      budget = budget_fixture()
      assert {:ok, %Budget{}} = Financial.delete_budget(budget)
      assert_raise Ecto.NoResultsError, fn -> Financial.get_budget!(budget.id) end
    end

    test "change_budget/1 returns a budget changeset" do
      budget = budget_fixture()
      assert %Ecto.Changeset{} = Financial.change_budget(budget)
    end
  end
end
