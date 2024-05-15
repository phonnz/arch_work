defmodule ArchWorkWeb.PostsLive.Index do
  use ArchWorkWeb, :live_view

  alias ArchWork.Locations
  alias ArchWork.Locations.Posts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :posts_collection, Locations.list_posts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Posts")
    |> assign(:posts, Locations.get_posts!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Posts")
    |> assign(:posts, %Posts{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Posts")
    |> assign(:posts, nil)
  end

  @impl true
  def handle_info({ArchWorkWeb.PostsLive.FormComponent, {:saved, posts}}, socket) do
    {:noreply, stream_insert(socket, :posts_collection, posts)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    posts = Locations.get_posts!(id)
    {:ok, _} = Locations.delete_posts(posts)

    {:noreply, stream_delete(socket, :posts_collection, posts)}
  end
end
