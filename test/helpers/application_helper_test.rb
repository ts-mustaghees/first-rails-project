require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
    test "full title helper" do
        assert_equal full_title, 'Learning Ruby'
        assert_equal full_title("Help"), 'Help | Learning Ruby'
      end
end