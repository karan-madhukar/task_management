defmodule TaskManagementWeb.TaskGroupView do
  use TaskManagementWeb, :view

  alias TaskManagement.TaskGroups

  def get_completed_and_total_task(task_group) do
    TaskGroups.get_completed_and_total_task(task_group)
  end

  def is_independent_task?(task_id) do
    TaskGroups.is_independent_task?(task_id)
  end
end
