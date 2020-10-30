require 'test_helper'

class DashbordControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get dashbord_index_url
    assert_response :success
  end
end
