defmodule VoiceChat.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      # supervisor(VoiceChat.Repo, []), # TODO(langep): ENABLE THIS AGAIN ONCE WE ARE USING A DATABASE
      # Start the endpoint when the application starts
      supervisor(VoiceChatWeb.Endpoint, []),
      supervisor(VoiceChatWeb.Presence, []),
      # Start your own worker by calling: VoiceChat.Worker.start_link(arg1, arg2, arg3)
      # worker(VoiceChat.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VoiceChat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    VoiceChatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
