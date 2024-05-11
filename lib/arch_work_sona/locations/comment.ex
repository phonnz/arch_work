defmodule ArchWorkSona.Locations.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "comments" do
    field :content, :string
    field :up_votes, :integer
    field :author_id, :binary_id
    field :post_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:content, :up_votes])
    |> validate_required([:content, :up_votes])
  end
end
