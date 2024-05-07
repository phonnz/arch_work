defmodule ArchWorkSona.FinancialFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ArchWorkSona.Financial` context.
  """

  @doc """
  Generate a budget.
  """
  def budget_fixture(attrs \\ %{}) do
    {:ok, budget} =
      attrs
      |> Enum.into(%{

      })
      |> ArchWorkSona.Financial.create_budget()

    budget
  end
end
