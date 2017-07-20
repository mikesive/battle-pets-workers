# I like to have a dispatcher queue seperate from other workers
# This is because if the operation succeeded, but the connection fails
# we don't have to reperform the operation, we can just keep trying
# to send the message

class DispatchWorker < BaseWorker
  sidekiq_options queue: 'workers'

  def perform(worker_name, payload)
    Sidekiq::Client.push(
      'class' => worker_name,
      'args' => [payload],
      'queue' => 'management'
    )
  end
end
