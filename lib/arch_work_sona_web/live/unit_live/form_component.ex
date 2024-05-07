defmodule ArchWorkSonaWeb.UnitLive.FormComponent do
  use ArchWorkSonaWeb, :live_component

  alias ArchWorkSona.Items

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage unit records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="unit-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:sname]} type="text" label="Sname" />
        <.input field={@form[:description]} type="text" label="Description" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Unit</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{unit: unit} = assigns, socket) do
    changeset = Items.change_unit(unit)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"unit" => unit_params}, socket) do
    changeset =
      socket.assigns.unit
      |> Items.change_unit(unit_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"unit" => unit_params}, socket) do
    save_unit(socket, socket.assigns.action, unit_params)
  end

  defp save_unit(socket, :edit, unit_params) do
    case Items.update_unit(socket.assigns.unit, unit_params) do
      {:ok, unit} ->
        notify_parent({:saved, unit})

        {:noreply,
         socket
         |> put_flash(:info, "Unit updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_unit(socket, :new, unit_params) do
    case Items.create_unit(unit_params) do
      {:ok, unit} ->
        notify_parent({:saved, unit})

        {:noreply,
         socket
         |> put_flash(:info, "Unit created successfully")
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
