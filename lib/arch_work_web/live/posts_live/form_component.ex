defmodule ArchWorkWeb.PostsLive.FormComponent do
  use ArchWorkWeb, :live_component

  alias ArchWork.Locations

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage posts records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="posts-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:content]} type="text" label="Content" />
        <.input field={@form[:votes]} type="number" label="Votes" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Posts</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{posts: posts} = assigns, socket) do
    changeset = Locations.change_posts(posts)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"posts" => posts_params}, socket) do
    changeset =
      socket.assigns.posts
      |> Locations.change_posts(posts_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"posts" => posts_params}, socket) do
    save_posts(socket, socket.assigns.action, posts_params)
  end

  defp save_posts(socket, :edit, posts_params) do
    case Locations.update_posts(socket.assigns.posts, posts_params) do
      {:ok, posts} ->
        notify_parent({:saved, posts})

        {:noreply,
         socket
         |> put_flash(:info, "Posts updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_posts(socket, :new, posts_params) do
    case Locations.create_posts(posts_params) do
      {:ok, posts} ->
        notify_parent({:saved, posts})

        {:noreply,
         socket
         |> put_flash(:info, "Posts created successfully")
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
