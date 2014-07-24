namespace :scheduler do
  task weekdays: [:notify_summoned_jurors]

  desc "check jury notificaiton website and notify summoned jurors"
  task notify_summoned_jurors: :environment do
    unless Date.current.strftime("%A").in? %w{Saturday Sunday}
      Resque.enqueue(NotifySummonedJurors)
    end
  end
end
