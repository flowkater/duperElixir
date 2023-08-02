defmodule Duper.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Duper.Results,
      {Duper.PathFinder, "."},
      Duper.WorkerSupervisor,
      {Duper.Gatherer, 5}
      # Starts a worker by calling: Duper.Worker.start_link(arg)
      # {Duper.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    # :one_for_one: 하나의 자식 프로세스가 실패하면 해당 자식 프로세스만 재시작합니다. 다른 자식 프로세스는 영향을 받지 않습니다.
    # :one_for_all: 하나의 자식 프로세스가 실패하면 모든 자식 프로세스를 재시작합니다. 이 옵션은 모든 자식 프로세스가 서로 의존하는 경우에 유용합니다.
    # :rest_for_one: 하나의 자식 프로세스가 실패하면 해당 자식 프로세스와 그 이후의 모든 자식 프로세스를 재시작합니다. 이 옵션은 실패한 자식 프로세스 이후에 시작된 자식 프로세스들이 서로 의존하는 경우에 유용합니다.
    # :simple_one_for_one: :one_for_one 전략과 유사하지만, 자식 프로세스를 동적으로 생성할 수 있습니다. 이 옵션은 동적으로 생성되는 자식 프로세스가 서로 독립적인 경우에 유용합니다.
    opts = [strategy: :one_for_all, name: Duper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
