module ApplicationHelper
  def flash_class_helper(my_type)
    {
      notice: 'success',
      success: 'success',
      error: 'danger',
      alert: 'danger',
      warning: 'warning'
    }[my_type.to_sym]
  end

  def flash_prefix_helper(my_type)
    {
      notice: 'Notice!',
      success: 'Success!',
      error: 'Error!',
      alert: 'Alert!',
      warning: 'Warning!'
    }[my_type.to_sym]
  end
end
