# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TaskManagement.Repo.insert!(%TaskManagement.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias TaskManagement.TaskGroups.{Task, TaskGroup, DependentTask}
alias TaskManagement.Repo
import Ecto.Query

date_time = DateTime.utc_now() |> DateTime.truncate(:second) |> DateTime.to_naive()

task_group_attrs = [
  %{name: "Task Group 1", inserted_at: date_time, updated_at: date_time},
  %{name: "Task Group 2", inserted_at: date_time, updated_at: date_time}
]

Repo.insert_all(TaskGroup, task_group_attrs)

task_groups = Repo.all(TaskGroup)
first_task_group_id = Enum.at(task_groups, 0).id
second_task_group_id = Enum.at(task_groups, 1).id

task_attrs = [
  %{
    name: "Sub Task 1 of group 1",
    task_group_id: first_task_group_id,
    inserted_at: date_time,
    updated_at: date_time
  },
  %{
    name: "Sub Task 2 of group 1",
    task_group_id: first_task_group_id,
    inserted_at: date_time,
    updated_at: date_time
  },
  %{
    name: "Sub Task 3 of group 1",
    task_group_id: first_task_group_id,
    inserted_at: date_time,
    updated_at: date_time
  },
  %{
    name: "Sub Task 1 of group 2",
    task_group_id: second_task_group_id,
    inserted_at: date_time,
    updated_at: date_time
  },
  %{
    name: "Sub Task 2 of group 2",
    task_group_id: second_task_group_id,
    inserted_at: date_time,
    updated_at: date_time
  }
]

Repo.insert_all(Task, task_attrs)

first_group_tasks = Repo.all(from(t in Task, where: t.task_group_id == ^first_task_group_id))
task1_id = Enum.at(first_group_tasks, 0).id
task2_id = Enum.at(first_group_tasks, 1).id
task3_id = Enum.at(first_group_tasks, 2).id

second_group_tasks = Repo.all(from(t in Task, where: t.task_group_id == ^second_task_group_id))
task4_id = Enum.at(second_group_tasks, 0).id
task5_id = Enum.at(second_group_tasks, 1).id

dependent_task_attrs = [
  %{
    task_id: task1_id,
    dependent_id: task2_id,
    inserted_at: date_time,
    updated_at: date_time
  },
  %{
    task_id: task2_id,
    dependent_id: task3_id,
    inserted_at: date_time,
    updated_at: date_time
  },
  %{
    task_id: task4_id,
    dependent_id: task5_id,
    inserted_at: date_time,
    updated_at: date_time
  }
]

Repo.insert_all(DependentTask, dependent_task_attrs)
