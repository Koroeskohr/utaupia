# Utaupia-test

## Installation

```
git clone https://github.com/koroeskohr/utaupia-test
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-librarian-chef-nochef
vagrant up
vagrant ssh
git config --global user.name "Ton nom wsh"
git config --global user.email "Ton email wsh"

cd project
ruby /bin/postinstall

rake db:migrate
rails server
```

### Dans ton navigateur :

127.0.0.1:3000


MAINTENANT TU FAIS DU RUBY, OK ?