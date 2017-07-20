class RecruitmentWorker < BaseWorker
  sidekiq_options queue: 'workers'

  def perform(params)
    generator = AttributeGenerator.new(params)
    attributes = generator.generate_attrs
    pet_id = params['id']
    user_id = params['user_id']

    payload = attributes.merge(
      'id': pet_id,
      'user_id': user_id
    )

    dispatch_async('RecruitmentFinalizationWorker', payload)
  end
end

