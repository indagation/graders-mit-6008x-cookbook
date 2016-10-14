bash "Remove All Cronjobs" do  
  user 'root'
  code 'crontab -u root -r'
  only_if 'crontab -u root -l'
end

cron 'Update Grader Repo' do
  minute '15'
  user 'root'
  mailto 'indagation@gmail.com'
  command %W{
    cd /home/ubuntu/graders-mit-6008x
    git pull
  }.join(' ')
end

execute 'Run Grader in Background' do
  cwd '/home/ubuntu/graders-mit-6008x'
  command 'nohup sudo python -m xqueue_watcher -d conf.d >> ../grader.out 2>&1&'
end