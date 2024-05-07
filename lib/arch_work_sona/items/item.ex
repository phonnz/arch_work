defmodule ArchWorkSona.Items.Item do
  use Ecto.Schema
  import Ecto.Changeset
  alias ArchWorkSona.Items.Unit

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "items" do
    field :name, :string
    field :fixed_price, Money.Ecto.Amount.Type
    belongs_to :unit, Unit

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :fixed_price])
    |> validate_required([:name, :fixed_price])
  end
end
