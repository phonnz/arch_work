defmodule ArchWorkSonaWeb.BudgetLive.Index do
  use ArchWorkSonaWeb, :live_view

  alias ArchWorkSona.Financial
  alias ArchWorkSona.Financial.Budget

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :budgets, Financial.list_budgets())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Budget")
    |> assign(:budget, Financial.get_budget!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Budget")
    |> assign(:budget, %Budget{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Budgets")
    |> assign(:budget, nil)
  end

  @impl true
  def handle_info({ArchWorkSonaWeb.BudgetLive.FormComponent, {:saved, budget}}, socket) do
    {:noreply, stream_insert(socket, :budgets, budget)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    budget = Financial.get_budget!(id)
    {:ok, _} = Financial.delete_budget(budget)

    {:noreply, stream_delete(socket, :budgets, budget)}
  end
end
