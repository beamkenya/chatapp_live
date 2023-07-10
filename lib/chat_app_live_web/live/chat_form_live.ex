defmodule ChatAppLiveWeb.ChatFormLive do
  use ChatAppLiveWeb, :live_view

  alias ChatAppLive.Messages
  alias ChatAppLive.Messages.Message

  def mount(_params, _session, socket) do
    messages = Messages.list_messages()
    {:ok, assign(socket, form: to_form(Messages.change_message(%Message{})), messages: messages)}
  end

  def handle_event("save", %{"message" => message_params}, socket) do
    case Messages.create_message(message_params) do
      {:ok, _message} ->
        {:noreply, assign(socket, push_patch(socket, to: ~p"/messages"))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
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

    <div>
      <h1 class="mb-4 text-4xl font-extrabold leading-none tracking-tight text-gray-900 md:text-5xl lg:text-6xl dark:text-white">
        Messages
      </h1>
    </div>

    <div class="flex items-start space-y-10">
      <ul role="list" class="divide-y divide-gray-100">
        <%= for  message <- @messages do %>
          <li class="flex flex-wrap items-center justify-between gap-x-6 gap-y-4 py-5 sm:flex-nowrap">
            <div>
              <p class="text-sm font-semibold leading-6 text-gray-900">
                <a href="#" class="hover:underline">
                  <%= message.content %>
                </a>
              </p>
              <div class="mt-1 flex items-center gap-x-2 text-xs leading-5 text-gray-500">
                <p>
                  <a href="#" class="hover:underline">Njoki K</a>
                </p>
                <svg viewBox="0 0 2 2" class="h-0.5 w-0.5 fill-current">
                  <circle cx="1" cy="1" r="1" />
                </svg>
                <p><time datetime="2023-01-23T22:34Z">2d ago</time></p>
              </div>
            </div>
            <dl class="flex w-full flex-none justify-between gap-x-8 sm:w-auto">
              <div class="flex -space-x-0.5">
                <a
                  href="#"
                  class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800"
                >
                  Edit
                </a>
              </div>
              <div class="flex w-16 gap-x-2.5">
                <dt>
                  <span class="sr-only">Total comments</span>
                  <svg
                    class="h-6 w-6 text-gray-400"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke-width="1.5"
                    stroke="currentColor"
                    aria-hidden="true"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      d="M2.25 12.76c0 1.6 1.123 2.994 2.707 3.227 1.087.16 2.185.283 3.293.369V21l4.076-4.076a1.526 1.526 0 011.037-.443 48.282 48.282 0 005.68-.494c1.584-.233 2.707-1.626 2.707-3.228V6.741c0-1.602-1.123-2.995-2.707-3.228A48.394 48.394 0 0012 3c-2.392 0-4.744.175-7.043.513C3.373 3.746 2.25 5.14 2.25 6.741v6.018z"
                    />
                  </svg>
                </dt>
                <dd class="text-sm leading-6 text-gray-900">2</dd>
              </div>
            </dl>
          </li>
        <% end %>
      </ul>
    </div>
    """
  end
end
