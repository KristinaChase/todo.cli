defmodule CLI do
  alias Todo

  @doc #Розпочинаємо інтерфейс командного рядка [далі підписую як CLI] та прописую команди користувача
  def start() do
    todo = Todo.new()
    loop(todo)
  end

  defp loop(todo) do
    IO.puts("Commands: add <task>, list, delete <index>, quit")
    command = IO.gets("> ") |> String.trim()

    new_todo =
      case String.split(command) do
        ["add" | task] ->
          task = Enum.join(task, " ")
          todo = Todo.add_task(todo, task)
          IO.puts("Завдання видалено.")
          todo

        ["list"] ->
          IO.puts("Завдання:")
          Enum.with_index(Todo.list_tasks(todo))
          |> Enum.each(fn {task, index} -> IO.puts("#{index + 1}. #{task}") end)
          todo

        ["delete", index_str] ->
          case Integer.parse(index_str) do
            {index, _} when index > 0 ->
              todo = Todo.delete_task(todo, index - 1)
              IO.puts("Завдання видалено.")
              todo

            :error ->
              IO.puts("Немає що видаляти!")
              todo
          end

        ["quit"] ->
          IO.puts("Допобачення!")
          :stop

        _ ->
          IO.puts("Неправильне значення, будь-ласка спробуйте ще раз!")
          todo
      end

    if new_todo != :stop do
      loop(new_todo)
    end
  end
end
