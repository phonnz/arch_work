defmodule ArchWorkSona.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias ArchWorkSona.Accounts.User
  alias ArchWorkSona.Locations.Building

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "posts" do
    field :content, :string
    belongs_to :building, Building
    belongs_to :author, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:building_id, :author_id, :content])
    |> validate_required([:content])
    |> validate_length(:content, min: 10, max: 140)
  end
end
