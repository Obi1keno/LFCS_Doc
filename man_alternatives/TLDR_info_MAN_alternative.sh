####_TLDR_####
# LDR is a collection of simplified and community-driven man pages. #
# Unlike man pages, TLDR pages only focuses on practical examples. #
yum install -y gcc-c++ make && curl -sL https://rpm.nodesource.com/setup_6.x | sudo -E bash - # add node.js yum repository.
yum install -y nodejs # install NPM which is a package manager for JavaScript.
node -v && npm -v # check install.
npm install -g tldr # install tldr using npm.
tldr find # example of find command.
tldr --list-all # list all.
