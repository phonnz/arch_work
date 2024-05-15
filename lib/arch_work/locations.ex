defmodule ArchWork.Locations do
  @moduledoc """
  The Locations context.
  """

  import Ecto.Query, warn: false
  alias ArchWork.Repo

  alias ArchWork.Locations.Building

  @doc """
  Returns the list of buildings.

  ## Examples

      iex> list_buildings()
      [%Building{}, ...]

  """
  def list_buildings do
    Repo.all(Building)
  end

  @doc """
  Gets a single building.

  Raises `Ecto.NoResultsError` if the Building does not exist.

  ## Examples

      iex> get_building!(123)
      %Building{}

      iex> get_building!(456)
      ** (Ecto.NoResultsError)

  """
  def get_building!(id), do: Repo.get!(Building, id)

  @doc """
  Creates a building.

  ## Examples

      iex> create_building(%{field: value})
      {:ok, %Building{}}

      iex> create_building(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_building(attrs \\ %{}) do
    %Building{}
    |> Building.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a building.

  ## Examples

      iex> update_building(building, %{field: new_value})
      {:ok, %Building{}}

      iex> update_building(building, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_building(%Building{} = building, attrs) do
    building
    |> Building.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a building.

  ## Examples

      iex> delete_building(building)
      {:ok, %Building{}}

      iex> delete_building(building)
      {:error, %Ecto.Changeset{}}

  """
  def delete_building(%Building{} = building) do
    Repo.delete(building)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking building changes.

  ## Examples

      iex> change_building(building)
      %Ecto.Changeset{data: %Building{}}

  """
  def change_building(%Building{} = building, attrs \\ %{}) do
    Building.changeset(building, attrs)
  end

  alias ArchWork.Locations.Posts

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Posts{}, ...]

  """
  def list_posts do
    Repo.all(Posts)
  end

  @doc """
  Gets a single posts.

  Raises `Ecto.NoResultsError` if the Posts does not exist.

  ## Examples

      iex> get_posts!(123)
      %Posts{}

      iex> get_posts!(456)
      ** (Ecto.NoResultsError)

  """
  def get_posts!(id), do: Repo.get!(Posts, id)

  @doc """
  Creates a posts.

  ## Examples

      iex> create_posts(%{field: value})
      {:ok, %Posts{}}

      iex> create_posts(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_posts(attrs \\ %{}) do
    %Posts{}
    |> Posts.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a posts.

  ## Examples

      iex> update_posts(posts, %{field: new_value})
      {:ok, %Posts{}}

      iex> update_posts(posts, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_posts(%Posts{} = posts, attrs) do
    posts
    |> Posts.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a posts.

  ## Examples

      iex> delete_posts(posts)
      {:ok, %Posts{}}

      iex> delete_posts(posts)
      {:error, %Ecto.Changeset{}}

  """
  def delete_posts(%Posts{} = posts) do
    Repo.delete(posts)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking posts changes.

  ## Examples

      iex> change_posts(posts)
      %Ecto.Changeset{data: %Posts{}}

  """
  def change_posts(%Posts{} = posts, attrs \\ %{}) do
    Posts.changeset(posts, attrs)
  end
end
