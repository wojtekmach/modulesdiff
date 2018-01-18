for app <- [:elixir, :mix, :eex, :logger] do
  :ok = Application.ensure_started(app)
  {:ok, modules} = :application.get_key(app, :modules)

  for module <- modules do
    docs = Code.get_docs(module, :all)

    case docs[:moduledoc] do
      {_, moduledoc} when is_binary(moduledoc) ->
        for {{fun, arity}, _, _kind, _, _doc} <- docs[:docs] do
          IO.puts "#{inspect module}.#{fun}/#{arity}"
        end

        IO.puts ""

      _ ->
        :skip
    end
  end
end
