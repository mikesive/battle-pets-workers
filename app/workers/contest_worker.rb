class ContestWorker < BaseWorker
  def perform(params)
    first_contestant = params['first_contestant']
    second_contestant = params['second_contestant']
    battle_id = params['battle_id']
    battle_type = params['battle_type']
    simulator = BattleSimulator.new(first_contestant, second_contestant, battle_type)
    winner = simulator.simulate
    loser = first_contestant['id'] == winner['id'] ? second_contestant : first_contestant

    unique_hash = SecureRandom.uuid

    dispatch_async('BattleFinalizationWorker', { battle_id: battle_id, winner: winner, loser: loser, unique_hash: unique_hash })
  end
end
