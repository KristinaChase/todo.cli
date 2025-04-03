#lib/todo.ex
defmodule Todo do
  defstruct tasks: []

  @doc
       #Ініціалізуємо новий список завдань/справ
  def new() do
    %Todo{}
  end

  @doc
       #Додаємо завдання в todo list
  def add_task(%Todo{tasks: tasks} = todo, task) do
    %Todo{todo | tasks: tasks ++ [task]}
  end

  @doc
      #Подивитися список всіх завдань
  def list_tasks(%Todo{tasks: tasks}) do
    tasks
  end

  @doc
        #Видаляємо всі завдання
  def delete_task(%Todo{tasks: tasks} = todo, index) when is_integer(index) and index >= 0 do
    if index < length(tasks) do
      tasks = List.delete_at(tasks, index)
      %Todo{todo | tasks: tasks}
    else
      IO.puts("Не вдалося видалити завдання, так як число завдань дорівнює: #{index}")
      todo
    end
  end
end
