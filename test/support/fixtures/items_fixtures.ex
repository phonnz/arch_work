defmodule ArchWorkSona.ItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ArchWorkSona.Items` context.
  """

  @doc """
  Generate a unit.
  """
  def unit_fixture(attrs \\ %{}) do
    {:ok, unit} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        sname: "some sname"
      })
      |> ArchWorkSona.Items.create_unit()

    unit
  end

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        fixed_price: 42,
        name: "some name"
      })
      |> ArchWorkSona.Items.create_item()

    item
  end
end
