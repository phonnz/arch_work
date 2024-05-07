defmodule ArchWorkSona.Repo.Migrations.CreateUnits do
  use Ecto.Migration

  def change do
    create table(:units, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :sname, :string
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end
