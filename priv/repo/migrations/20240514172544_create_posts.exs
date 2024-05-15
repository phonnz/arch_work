defmodule ArchWork.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :content, :string
      add :votes, :integer
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :building_id, references(:buildings, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:posts, [:user_id, :building_id])
  end
end
