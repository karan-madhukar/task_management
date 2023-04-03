defmodule TaskManagement.Repo.Migrations.CreateDependentTask do
  use Ecto.Migration

  def change do
    create table(:dependent_tasks) do
      add :task_id, references(:tasks, on_delete: :nothing)
      add :dependent_id, references(:tasks, on_delete: :nothing)

      timestamps()
    end

    create index(:dependent_tasks, [:task_id])
    create index(:dependent_tasks, [:dependent_id])
    create unique_index(:dependent_tasks, [:task_id, :dependent_id])
  end
end
