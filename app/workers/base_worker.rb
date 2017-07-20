class BaseWorker
  include Sidekiq::Worker

  def perform(_params)
  end

  protected

  def dispatch_async(url, payload)
    DispatchWorker.perform_async(url, payload)
  end
end
