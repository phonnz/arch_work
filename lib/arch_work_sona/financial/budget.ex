defmodule ArchWorkSona.Financial.Budget do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "budgets" do

    field :building, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(budget, attrs) do
    budget
    |> cast(attrs, [])
    |> validate_required([])
  end
end
