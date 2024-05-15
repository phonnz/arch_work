defmodule ArchWorkWeb.PostsLive.Show do
  use ArchWorkWeb, :live_view

  alias ArchWork.Locations

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:posts, Locations.get_posts!(id))}
  end

  defp page_title(:show), do: "Show Posts"
  defp page_title(:edit), do: "Edit Posts"
end
