execute 'Run Grader in Background' do
  cwd '/home/ubuntu/graders-mit-6008x'
  command 'nohup sudo python -m xqueue_watcher -d conf.d >> ../grader.out 2>&1&'
end