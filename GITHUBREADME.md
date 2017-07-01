
### Multiple git-hub account setting

ssh-agent : process runs in background that holds private and publie keys (RSA,DSA,etc.)
To start the process 
$eval `ssh-agent -s`

Verfiy wheather ssh-agent is started or not 
$pgrep ssh-agent

To list out stored keys in the ssh-agent
$ssh-add -L  or
$ssh-add -l

To add the keys in the ssh-agent
$ssh-add ${pvt_key_file_path}

To delete all the keys in the ssh-agent
$ssh-add -D

### github debug
$ssh -vT git@github.com
### For multiple or no keys to set preference use 
$ssh -i ${pvt_key_file} -vT git@github.com

Generate the rsa key 
$ssh-keygen -t rsa -C "my_email@gmail.com"
DO the cleanup
$rm -rf ${HOME}/.ssh/config

To get more info
$man ssh-agent

Get more 
http://docstore.mik.ua/orelly/networking_2ndEd/ssh/ch06_01.htm

