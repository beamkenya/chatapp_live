defmodule ChatAppLiveWeb.ChatFormComponent do
  use ChatAppLiveWeb, :live_component

  alias ChatAppLive.Messages
  alias ChatAppLive.Messages.Message

  def mount(socket) do
    changeset = Messages.change_message(%Message{})
    {:ok, assign(socket, form: to_form(changeset))}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.form for={@form} phx-submit="save" phx-target={@myself}>
        <label for="comment" class="sr-only text-red-700">Add your comment</label>
        <.input type="textarea" field={@form[:content]} />

        <div class="flex-shrink-0">
          <button
            type="submit"
            class="inline-flex items-center rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
          >
            Post
          </button>
        </div>
      </.form>
    </div>
    """
  end

  def handle_event("save", %{"message" => message_params}, socket) do
    case Messages.create_message(message_params) do
      {:ok, message} ->
        send(self(), {:message_created, message})

        changeset = Messages.change_message(%Message{})
        {:noreply, assign(socket, form: to_form(changeset))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end
end
