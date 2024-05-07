defmodule ArchWorkSona.Repo.Migrations.CreateBuildings do
  use Ecto.Migration

  def change do
    create table(:buildings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :address, :text

      timestamps(type: :utc_datetime)
    end
  end
end
