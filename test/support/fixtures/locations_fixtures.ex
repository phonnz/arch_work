defmodule ArchWorkSona.LocationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ArchWorkSona.Locations` context.
  """

  @doc """
  Generate a building.
  """
  def building_fixture(attrs \\ %{}) do
    {:ok, building} =
      attrs
      |> Enum.into(%{
        address: "some address",
        name: "some name"
      })
      |> ArchWorkSona.Locations.create_building()

    building
  end

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        content: "some content",
        up_votes: 42
      })
      |> ArchWorkSona.Locations.create_comment()

    comment
  end
end
