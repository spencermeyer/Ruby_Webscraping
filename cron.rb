# this shall be the target file of a cron job
# purpose to refresh the webpage
#
require 'mechanize'
agent=Mechanize.new
agent.user_agent_alias = 'Mechanize'
doc = agent.get('http://parkcollectoronrails.co.uk/')
puts doc.inspect
