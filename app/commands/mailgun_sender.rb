class MailgunSender < AuthenticationController
  prepend SimpleCommand

  def initialize(user_email, user_name, job)
		@user_email = user_email
    @user_name = user_name
    @job = job
  end

  def call
    @org_names_string = @job.orgs.collect { |o| o.name }.join(", ")
    @to_email_string = get_to_emails
    @text = get_email_body
    @subject = (@job.title + " - Hjobs.hk")
    RestClient.post "https://api:key-fd356a2576890b2ab691c0b5064a09a3@api.mailgun.net/v3/hjobs.hk/messages",
      :from => "<application@hjobs.hk>",
      :to => @to_email_string,
      :subject => @subject,
      :text => @text,
      "h:Reply-To": @user_email
  end

  private

    def get_to_emails
      return @job.email if !!@job[:email] && !@job.email.empty?
      return @job.orgs.collect { |o| o.email }.join(", ")
    end

    def get_email_body
      ("Dear " + @org_names_string + ",\n\n" +
      "I am interested in your posting " + @job.title + ". Please contact me at: " + @user_email + "\n\n" +
      "Look forward to your speedy reply,\n" +
      @user_name)
    end
end
