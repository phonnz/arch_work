defmodule ArchWorkSona.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ArchWorkSona.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        content: "some content"
      })
      |> ArchWorkSona.Posts.create_post()

    post
  end
end
