# frozen_string_literal: true

class DeviseMailer < ApplicationMailer
  default from: 'from@example.com'
  layout 'devise/mailer'
end
