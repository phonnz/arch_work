defmodule ArchWorkSona.Repo.Migrations.CreateBudgets do
  use Ecto.Migration

  def change do
    create table(:budgets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :building, references(:buildings, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:budgets, [:building])
  end
end
