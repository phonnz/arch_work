defmodule ArchWorkWeb.BuildingLive.Index do
  use ArchWorkWeb, :live_view

  alias ArchWork.Locations
  alias ArchWork.Locations.Building

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :buildings, Locations.list_buildings())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Building")
    |> assign(:building, Locations.get_building!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Building")
    |> assign(:building, %Building{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Buildings")
    |> assign(:building, nil)
  end

  @impl true
  def handle_info({ArchWorkWeb.BuildingLive.FormComponent, {:saved, building}}, socket) do
    {:noreply, stream_insert(socket, :buildings, building)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    building = Locations.get_building!(id)
    {:ok, _} = Locations.delete_building(building)

    {:noreply, stream_delete(socket, :buildings, building)}
  end
end
