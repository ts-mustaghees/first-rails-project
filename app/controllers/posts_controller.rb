class PostsController < ApplicationController
    def index
        @author = 'Steve Jobs'
        @publish_date = Date.today
        @title = 'Hello Ruby'
        @body = 'This is a practice ruby on rails project'
    end
end
