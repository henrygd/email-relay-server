require 'test_helper'

class RelayMailerTest < ActionMailer::TestCase
  test "relay_mail" do
    args = {
      email: 'me@example.com',
      name: 'Testy McGee',
      fromEmail: 'you@example.com',
      message: 'Hello, this is a message!'
    }
    mail = RelayMailer.relay_mail(args, 'example.com')
    assert_equal "New message on example.com", mail.subject
    assert_equal ["me@example.com"], mail.to
    assert_equal ["emailrelay@henrygd.me"], mail.from
    assert_equal ["you@example.com"], mail.reply_to
    assert_match "Hello, this is a message!", mail.body.encoded
  end

  test "relay_mail_with_subject" do
    args = {
      email: 'me@example.com',
      name: 'Testy McGee',
      subject: "This is a subject",
      fromEmail: 'you@example.com',
      message: 'Hello, this is a message!'
    }
    mail = RelayMailer.relay_mail(args, 'example.com')
    assert_equal "This is a subject", mail.subject
    assert_equal ["me@example.com"], mail.to
    assert_equal ["emailrelay@henrygd.me"], mail.from
    assert_equal ["you@example.com"], mail.reply_to
    assert_match "Hello, this is a message!", mail.body.encoded
  end

end
