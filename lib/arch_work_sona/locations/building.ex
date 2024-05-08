defmodule ArchWorkSona.Locations.Building do
  use Ecto.Schema
  import Ecto.Changeset
  alias ArchWorkSona.Posts.Post

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "buildings" do
    field :name, :string
    field :address, :string
    has_many :posts, Post

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(building, attrs) do
    building
    |> cast(attrs, [:name, :address])
    |> validate_required([:name, :address])
  end
end
