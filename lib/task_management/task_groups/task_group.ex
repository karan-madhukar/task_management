defmodule TaskManagement.TaskGroups.TaskGroup do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskManagement.TaskGroups.{Task, TaskGroup}

  schema "task_groups" do
    field(:name, :string)

    has_many(:task, Task)
    timestamps()
  end

  def changeset(%TaskGroup{} = task_group, attrs) do
    task_group
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
