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
    RestClient.post "https://api:" + ENV["MAILGUNAPIKEY"] + "@api.mailgun.net/v3/hjobs.hk/messages",
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
      ("Hello " + @org_names_string + ",\n\n" +
      @user_name + " has appied for your job with title: \"" + @job.title +
      "\". Please see applicant details and updates of the job posting at https://admin.hjobs.hk.\n\n" +
      "Cheers,\nHJobs")
    end
end
