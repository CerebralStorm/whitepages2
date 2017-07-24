defmodule Whitepages2.TableQueryBuilder do
  import Ecto.Query

  def filter_by_from(query, params) do
    params[:from]
    |> case do
      nil  -> query
      ""   -> query
      text -> query |> where(from: ^text)
    end
  end

  def filter_by_date(query, []), do: query
  def filter_by_date(query, list) do
    interval = list[:date] |> String.to_integer

    date = Timex.now
           |> Timex.shift(days: -interval)
           |> Ecto.DateTime.cast!

    query
    |> where([e], e.date_sent > ^date)
  end

  def filter_by_status(query, params) do
    filters = set_status(params)

    query
    |> where([e], e.status in ^filters)
  end

  defp set_status(params) do
    params
    |> Keyword.take(~w(bounced sent complaint)a)
    |> Keyword.values
    |> Enum.uniq
    |> Enum.count
    |> case do
      1 -> ["sent", "bounced", "complaint"]
      _ -> fetch_status_filters(params)
    end
  end

  defp fetch_status_filters(params) do
    params
    |> Keyword.to_list
    |> Enum.filter(fn({k, v}) ->
      v == "true"
    end)
    |> Enum.map(fn({k,v}) ->
      Atom.to_string(k)
    end)
  end

  def filter_by_search(query, params) do
    params[:q]
    |> case do
      nil  -> query
      ""   -> query
      text -> query |> where([r], ilike(r.subject, ^("%#{text}%")))
    end
  end
end