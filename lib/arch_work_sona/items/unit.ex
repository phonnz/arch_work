defmodule ArchWorkSona.Items.Unit do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "units" do
    field :name, :string
    field :description, :string
    field :sname, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(unit, attrs) do
    unit
    |> cast(attrs, [:name, :sname, :description])
    |> validate_required([:name, :sname, :description])
  end
end
