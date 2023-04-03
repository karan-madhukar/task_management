defmodule TaskManagement.TaskGroups.DependentTask do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias TaskManagement.TaskGroups.{DependentTask, Task}

  schema "dependent_tasks" do
    belongs_to(:task, Task, foreign_key: :task_id)
    belongs_to(:dependent, Task, foreign_key: :dependent_id)

    timestamps()
  end

  def changeset(%DependentTask{} = dependent_task, attrs) do
   dependent_task
    |> cast(attrs, [:task_id, :dependent_id])
    |> validate_required([:task_id, :dependent_id])
    |> foreign_key_constraint(:task_id)
    |> foreign_key_constraint(:dependent_id)
    |> unique_constraint(:dependent_task, name: :dependent_tasks_task_id_dependent_id_index)
  end
end
