namespace :scheduler do
  task weekdays: [:notify_summoned_jurors]

  desc "check jury notificaiton website and notify summoned jurors"
  task notify_summoned_jurors: :environment do
    Resque.enqueue(NotifySummonedJurors)
  end
end
