def current_week
  # we want current week to roll over on friday
  # on friday notices are posted for following monday
  3.days.since(Date.current).beginning_of_week
end
