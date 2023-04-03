defmodule TaskManagement.TaskGroups.Task do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskManagement.TaskGroups.{DependentTask, Task, TaskGroup}

  schema "tasks" do
    field(:name, :string)
    field(:is_completed, :boolean, default: false)

    belongs_to(:task_group, TaskGroup)
    has_many :tasks, DependentTask, foreign_key: :task_id
    has_many :dependents, DependentTask, foreign_key: :dependent_id
    timestamps()
  end

  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:name, :is_completed, :task_group_id])
    |> validate_required([:name, :is_completed, :task_group_id])
    |> unique_constraint(:name)
    |> foreign_key_constraint(:task_group_id)
  end

  def update_changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:is_completed])
    |> validate_required([:is_completed])
  end
end
