defmodule ChatAppLiveWeb.ChatFormLive do
  use ChatAppLiveWeb, :live_view

  alias ChatAppLive.Messages
  alias ChatAppLive.Messages.Message

  def mount(_params, _session, socket) do
    messages = Messages.list_messages
    {:ok, assign(socket, form: to_form(Messages.change_message(%Message{})), messages: messages)}
  end

  def render(assigns) do
    ~H"""
    <div class="flex items-start space-x-4">
      <div class="flex-shrink-0">
        <img
          class="inline-block h-10 w-10 rounded-full"
          src="https://images.unsplash.com/photo-1550525811-e5869dd03032?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
          alt=""
        />
      </div>
      <div class="min-w-0 flex-1">
        <.form for={@form} phx-submit="save">
          <label for="comment" class="sr-only">Add your comment</label>
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
    </div>



    <h1>Messages</h1>

    <table>

      <tbody>
      <%= for  message <- @messages do %>
        <tr>

          <td> <%= message.id %></td>
          <td> <%= message.content %></td>

        </tr>
        <% end %>
      </tbody>
    </table>
    """
  end

  def handle_event("save", %{"message" => message_params}, socket) do
    case Messages.create_message(message_params) do

      {:ok, _message} ->
        {:noreply, assign(socket, push_navigate(socket, to: ~p"/compose/message"))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end
end
