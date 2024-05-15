defmodule ArchWork.Repo.Migrations.CreateBuildings do
  use Ecto.Migration

  def change do
    create table(:buildings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :address, :string
      add :start_date, :date, null: false
      add :end_date, :date, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
