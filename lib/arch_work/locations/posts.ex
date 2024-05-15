defmodule ArchWork.Locations.Posts do
  use Ecto.Schema
  import Ecto.Changeset
  alias ArchWork.Locations.Building
  alias ArchWork.Accounst.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "posts" do
    field :content, :string
    field :votes, :integer
    belongs_to :user_id, User
    belongs_to :building_id, Building

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(posts, attrs) do
    posts
    |> cast(attrs, [:content, :votes])
    |> validate_required([:content, :votes])
  end
end
