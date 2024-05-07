defmodule ArchWorkSonaWeb.BudgetLive.FormComponent do
  use ArchWorkSonaWeb, :live_component

  alias ArchWorkSona.Financial

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage budget records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="budget-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >

        <:actions>
          <.button phx-disable-with="Saving...">Save Budget</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{budget: budget} = assigns, socket) do
    changeset = Financial.change_budget(budget)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"budget" => budget_params}, socket) do
    changeset =
      socket.assigns.budget
      |> Financial.change_budget(budget_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"budget" => budget_params}, socket) do
    save_budget(socket, socket.assigns.action, budget_params)
  end

  defp save_budget(socket, :edit, budget_params) do
    case Financial.update_budget(socket.assigns.budget, budget_params) do
      {:ok, budget} ->
        notify_parent({:saved, budget})

        {:noreply,
         socket
         |> put_flash(:info, "Budget updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_budget(socket, :new, budget_params) do
    case Financial.create_budget(budget_params) do
      {:ok, budget} ->
        notify_parent({:saved, budget})

        {:noreply,
         socket
         |> put_flash(:info, "Budget created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
