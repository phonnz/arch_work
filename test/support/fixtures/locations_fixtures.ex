defmodule ArchWork.LocationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ArchWork.Locations` context.
  """

  @doc """
  Generate a building.
  """
  def building_fixture(attrs \\ %{}) do
    {:ok, building} =
      attrs
      |> Enum.into(%{
        address: "some address",
        end_date: ~D[2024-05-13],
        name: "some name",
        start_date: ~D[2024-05-13]
      })
      |> ArchWork.Locations.create_building()

    building
  end

  @doc """
  Generate a posts.
  """
  def posts_fixture(attrs \\ %{}) do
    {:ok, posts} =
      attrs
      |> Enum.into(%{
        content: "some content",
        votes: 42
      })
      |> ArchWork.Locations.create_posts()

    posts
  end
end
