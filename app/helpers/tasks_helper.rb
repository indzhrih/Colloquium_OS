module TasksHelper
  def status_badge_color(status)
    case status
    when 'todo'
      'secondary'
    when 'in_progress'
      'warning'
    when 'done'
      'success'
    else 'light'
    end
  end
end
