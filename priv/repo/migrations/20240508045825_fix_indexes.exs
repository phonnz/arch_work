defmodule ArchWorkSona.Repo.Migrations.FixIndexes do
  use Ecto.Migration

  def change do
    rename table(:budgets), :building, to: :building_id
    rename table(:items), :unit, to: :unit_id
    rename table(:posts), :building, to: :building_id
    rename table(:posts), :author, to: :author_id
  end
end
