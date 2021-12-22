class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  GETUSERS = "/getusers".freeze
  GETTODOS = "/gettodos".freeze
  GETPHOTOS = "/getphotos".freeze
  GETPOSTS = "/getposts".freeze
  GETCOMMENTS = "/getcomments".freeze
  GETALBUMS = "/getalbums".freeze
  SLOWREQUEST = "/slowrequest".freeze
  BADWEBREQUEST = "/badwebrequest".freeze
end
