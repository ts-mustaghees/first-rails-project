require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "create should require login" do
    assert_no_difference 'Relationship.count' do
      post relationships_path
    end

    assert_redirected_to new_user_session_url
  end

  test "destroy should require login" do
    assert_no_difference 'Relationship.count' do
      delete relationship_path(relationships(:one))
    end

    assert_redirected_to new_user_session_url
  end
end
