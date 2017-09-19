task default: :run

task :build do
  sh "docker build . -t bbs"
end

task :run do
  sh "docker run -v $PWD:/home/bbs/robbs -p 9922:22 --name bbs --rm -ti bbs"
end

task :daemon  do
  sh "docker run -d -v $PWD:/home/bbs/robbs -p 9922:22 --name bbs --rm bbs"
end

task :kill do
  sh "docker kill bbs"
end
