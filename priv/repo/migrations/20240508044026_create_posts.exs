defmodule ArchWorkSona.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :content, :text
      add :building, references(:buildings, on_delete: :nothing, type: :binary_id), null: false
      add :author, references(:users, on_delete: :nothing, type: :binary_id), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:posts, [:building])
    create index(:posts, [:author])
  end
end
