defmodule TaskManagement.Repo.Migrations.CreateTask do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :name, :string, null: false
      add :is_completed, :boolean, default: false, null: false
      add :task_group_id, references(:task_groups, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:tasks, [:name])
  end
end
