bash "Remove All Cronjobs" do  
  user 'root'
  code 'crontab -u root -r'
  only_if 'crontab -u root -l'
end

cron 'Update Grader Repo' do
  minute '15'
  user 'root'
  command 'cd /home/ubuntu/graders-mit-6008x && git pull >> /home/ubuntu/git.log 2>&1'
end

cron 'Periodically Clear Grader Output' do
  hour '1'
  user 'root'
  command 'cat /dev/null > /home/ubuntu/grader.out'
end

execute 'Kill Python Graders' do
  command 'sudo pkill -9 python'
  returns [0,1]
end

execute 'Run Grader in Background' do
  cwd '/home/ubuntu/graders-mit-6008x'
  command 'nohup sudo python -m xqueue_watcher -d conf.d >> ../grader.out 2>&1&'
end