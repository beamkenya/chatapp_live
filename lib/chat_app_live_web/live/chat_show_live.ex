defmodule ChatAppLiveWeb.ChatShowLive do
  use ChatAppLiveWeb, :live_view

  alias ChatAppLive.Messages

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    message = Messages.get_message!(id)
    {:noreply, socket |> assign(message: message)}
  end

  def render(assigns) do
    ~H"""
    <div class="flex">
      <div class="mr-4 flex-shrink-0">
        <svg
          class="h-16 w-16 border border-gray-300 bg-white text-gray-300"
          preserveAspectRatio="none"
          stroke="currentColor"
          fill="none"
          viewBox="0 0 200 200"
          aria-hidden="true"
        >
          <path vector-effect="non-scaling-stroke" stroke-width="1" d="M0 0l200 200M0 200L200 0" />
        </svg>
      </div>
      <div>
        <p class="mt-1"><%= @message.content %></p>

        <div class="mt-6 flex">
          <div class="mr-4 flex-shrink-0">
            <svg
              class="h-12 w-12 border border-gray-300 bg-white text-gray-300"
              preserveAspectRatio="none"
              stroke="currentColor"
              fill="none"
              viewBox="0 0 200 200"
              aria-hidden="true"
            >
              <path vector-effect="non-scaling-stroke" stroke-width="1" d="M0 0l200 200M0 200L200 0" />
            </svg>
          </div>
          <div>
            <h4 class="text-lg font-bold">Comment 1</h4>
            <p class="mt-1">
              Repudiandae sint consequuntur vel. Amet ut nobis explicabo numquam expedita quia omnis voluptatem. Minus quidem ipsam quia iusto.
            </p>
          </div>
        </div>
        <div class="mt-6 flex">
          <div class="mr-4 flex-shrink-0">
            <svg
              class="h-12 w-12 border border-gray-300 bg-white text-gray-300"
              preserveAspectRatio="none"
              stroke="currentColor"
              fill="none"
              viewBox="0 0 200 200"
              aria-hidden="true"
            >
              <path vector-effect="non-scaling-stroke" stroke-width="1" d="M0 0l200 200M0 200L200 0" />
            </svg>
          </div>
          <div>
            <h4 class="text-lg font-bold">Comment 2</h4>
            <p class="mt-1">
              Repudiandae sint consequuntur vel. Amet ut nobis explicabo numquam expedita quia omnis voluptatem. Minus quidem ipsam quia iusto.
            </p>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
