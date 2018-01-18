apps = [:elixir, :mix, :eex, :logger, :iex, :ex_unit]
for app <- apps do
  :ok = Application.ensure_started(app)
  {:ok, modules} = :application.get_key(app, :modules)

  for module <- modules do
    docs = Code.get_docs(module, :all)

    case docs[:moduledoc] do
      {_, moduledoc} when is_binary(moduledoc) ->
        for {{fun, arity}, _, _kind, _, doc} <- docs[:docs] do
          if is_binary(doc) do
            IO.puts "#{inspect module}.#{fun}/#{arity}"
          end
        end

        IO.puts ""

      _ ->
        :skip
    end
  end
end
