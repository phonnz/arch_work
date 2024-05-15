defmodule ArchWork.Locations.Building do
  use Ecto.Schema
  import Ecto.Changeset

  alias ArchWork.Locations.Post

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "buildings" do
    field :name, :string
    field :address, :string
    field :start_date, :date
    field :end_date, :date
    has_many :posts, Post

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(building, attrs) do
    building
    |> cast(attrs, [:name, :address, :start_date, :end_date])
    |> validate_required([:name, :address, :start_date, :end_date])
  end
end
