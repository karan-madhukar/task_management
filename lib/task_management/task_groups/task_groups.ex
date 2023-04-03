defmodule TaskManagement.TaskGroups do
  @moduledoc false

  import Ecto.Query
  alias TaskManagement.Repo
  alias TaskManagement.TaskGroups.{Task, TaskGroup, DependentTask}

  @spec get_task!(any) :: any
  def get_task!(id), do: Repo.get!(Task, id)

  @spec list_task_groups :: any
  def list_task_groups() do
    Repo.all(TaskGroup)
  end

  @spec list_tasks(any) :: any
  def list_tasks(task_group_id) do
    from(t in Task,
      where: t.task_group_id == ^task_group_id,
      preload: :task_group,
      order_by: :id
    )
    |> Repo.all()
  end

  @spec get_completed_and_total_task(atom | %{:id => any, optional(any) => any}) ::
          {non_neg_integer, non_neg_integer}
  def get_completed_and_total_task(task_group) do
    tasks = list_tasks(task_group.id)

    {Enum.count(tasks, fn t -> t.is_completed == true end), Enum.count(tasks)}
  end

  @spec is_independent_task?(any) :: boolean
  def is_independent_task?(task_id) do
    from(dt in DependentTask,
      where: dt.task_id == ^task_id,
      preload: :dependent
    )
    |> Repo.all()
    |> Enum.all?(fn t -> is_nil(t.dependent) or t.dependent.is_completed == true end)
  end

  def update_task(task, attrs) do
    task
    |> Task.update_changeset(attrs)
    |> Repo.update()
  end
end
