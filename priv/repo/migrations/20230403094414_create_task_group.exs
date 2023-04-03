defmodule TaskManagement.Repo.Migrations.CreateTaskGroup do
  use Ecto.Migration

  def change do
    create table(:task_groups) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:task_groups, [:name])
  end
end
