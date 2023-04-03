defmodule TaskManagementWeb.TaskGroupController do
  use TaskManagementWeb, :controller

  alias TaskManagement.TaskGroups
  alias TaskManagement.TaskGroups.Task

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    task_groups = TaskGroups.list_task_groups()
    render(conn, "index.html", task_groups: task_groups)
  end

  def show(conn, %{"task_group_id" => task_group_id}) do
    tasks = TaskGroups.list_tasks(task_group_id)
    changeset = Task.changeset(%Task{}, %{})
    render(conn, "show.html", tasks: tasks, changeset: changeset)
  end

  def update_task(conn, %{"id" => id, "task" => task_params}) do
    task = TaskGroups.get_task!(id)
    tasks = TaskGroups.list_tasks(task.task_group_id)

    case TaskGroups.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> redirect(to: Routes.task_group_path(conn, :show, task.task_group_id))

      {:error, changeset} ->
        render(conn, "show.html", tasks: tasks, changeset: changeset)
    end
  end
end
